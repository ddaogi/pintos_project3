/* vm.c: Generic interface for virtual memory objects. */

#include "threads/malloc.h"
#include "vm/vm.h"
#include "vm/inspect.h"
//hash추가
#include <hash.h>
#include "threads/vaddr.h"
#include "threads/thread.h"
#include "threads/mmu.h"
#include <string.h>
#include "userprog/process.h"

/* Initializes the virtual memory subsystem by invoking each subsystem's
 * intialize codes. */
void
vm_init (void) {
	vm_anon_init ();
	vm_file_init ();
#ifdef EFILESYS  /* For project 4 */
	pagecache_init ();
#endif
	register_inspect_intr ();
	/* DO NOT MODIFY UPPER LINES. */
	/* TODO: Your code goes here. */
}

/* Get the type of the page. This function is useful if you want to know the
 * type of the page after it will be initialized.
 * This function is fully implemented now. */
enum vm_type
page_get_type (struct page *page) {
	int ty = VM_TYPE (page->operations->type);
	switch (ty) {
		case VM_UNINIT:
			return VM_TYPE (page->uninit.type);
		default:
			return ty;
	}
}

/* Helpers */
static struct frame *vm_get_victim (void);
static bool vm_do_claim_page (struct page *page);
static struct frame *vm_evict_frame (void);

/* Create the pending page object with initializer. If you want to create a
 * page, do not create it directly and make it through this function or
 * `vm_alloc_page`. */
bool
vm_alloc_page_with_initializer (enum vm_type type, void *upage, bool writable,
		vm_initializer *init, void *aux) {

			/* init은 lazy load segment를 받아옴 */

	ASSERT (VM_TYPE(type) != VM_UNINIT)

	struct supplemental_page_table *spt = &thread_current ()->spt;

	/* Check wheter the upage is already occupied or not. */
	if (spt_find_page (spt, upage) == NULL) {
		/* TODO: Create the page, fetch the initialier according to the VM type,
		 * TODO: and then create "uninit" page struct by calling uninit_new. You
		 * TODO: should modify the field after calling the uninit_new. */
		
		/*여기서 페이지를 만들어줌 VM type에 따른 initalizer를 fetch 해줌*/				
		struct page *new_page = (struct page*)malloc(sizeof(struct page));
		if(type == VM_ANON){
			uninit_new(new_page,upage,init,type,aux,anon_initializer);
		}else if(type == VM_FILE){
			uninit_new(new_page,upage,init,type,aux,file_backed_initializer);
		}else{
			return false;
		}
		/* TODO: Insert the page into the spt. */
		new_page->writable=writable;
		
		return spt_insert_page(spt, new_page);
	}
err:
	return false;
}

/* Find VA from spt and return page. On error, return NULL. 
	위의 함수는 인자로 넘겨진 보조 페이지 테이블에서로부터 가상 주소(va)와 대응되는 페이지 구조체를 찾아서 반환합니다. 
	실패했을 경우 NULL를 반환합니다.*/
struct page *
spt_find_page (struct supplemental_page_table *spt/*UNUSED*/, void *va /*UNUSED*/) {
	
	/* TODO: Fill this function. */

	struct page *temp_page = malloc(sizeof(struct page));

  	struct hash_elem *hash_elem;

  	temp_page->va = pg_round_down(va);
  	hash_elem = hash_find (spt->hash_vm, &temp_page->h_elem);
	if (hash_elem == NULL) {
		free(temp_page);
		return NULL;
	}
	free(temp_page);
	if( hash_elem != NULL){
		return hash_entry (hash_elem, struct page, h_elem);
	}else
		return NULL;
  	// return hash_elem != NULL ? hash_entry (hash_elem, struct page, h_elem) : NULL;

}

/* Insert PAGE into spt with validation. 
	위의 함수는 인자로 주어진 보조 페이지 테이블에 페이지 구조체를 삽입합니다. 
	이 함수에서 주어진 보충 테이블에서 가상 주소가 존재하지 않는지 검사해야 합니다.*/
bool
spt_insert_page (struct supplemental_page_table *spt /*UNUSED*/,
		struct page *page /*UNUSED*/) {
	// int succ = false;
	/* TODO: Fill this function. */
	struct hash_elem *insert_elem = hash_insert(spt->hash_vm, &page->h_elem);
	if(insert_elem == NULL){
		return true;
	}
	return false;
}

void
spt_remove_page (struct supplemental_page_table *spt, struct page *page) {
	vm_dealloc_page (page);
	return true;
}

/* Get the struct frame, that will be evicted. */
static struct frame *
vm_get_victim (void) {
	struct frame *victim = NULL;
	 /* TODO: The policy for eviction is up to you. */

	return victim;
}

/* Evict one page and return the corresponding frame.
 * Return NULL on error.*/
static struct frame *
vm_evict_frame (void) {
	struct frame *victim UNUSED = vm_get_victim ();
	/* TODO: swap out the victim and return the evicted frame. */

	return NULL;
}

/* palloc() and get frame. If there is no available page, evict the page
 * and return it. This always return valid address. That is, if the user pool
 * memory is full, this function evicts the frame to get the available memory
 * space.*/
static struct frame *
vm_get_frame (void) {
    struct frame *frame = (struct frame*) malloc(sizeof(struct frame));

    /* TODO: Fill this function. */
	/* */
	void* new_page = palloc_get_page(PAL_USER);

    if(new_page == NULL){
        PANIC("todo");
    }else{
        frame->kva = new_page;
        frame->page = NULL;
    }
    ASSERT (frame != NULL);
    ASSERT (frame->page == NULL);
	return frame;
}
/* Growing the stack. */
static void
vm_stack_growth (void *addr UNUSED) {
	/* PAGE 만큼 낮춰야한다.. */
	void* new_stack_bottom= pg_round_down(addr);
   	if(vm_alloc_page(VM_ANON, new_stack_bottom, true)){ 
		vm_claim_page(new_stack_bottom);
	}
}

/* Handle the fault on write_protected page */
static bool
vm_handle_wp (struct page *page UNUSED) {
}

/* Return true on success */
bool
vm_try_handle_fault (struct intr_frame *f , void *addr,
		bool user , bool write, bool not_present ) {
	/* addr은 page_fault에서 보낸 fault address */
	if(addr == NULL || is_kernel_vaddr(addr) || addr == 0x04000000){
		return false;
	}
	struct supplemental_page_table *spt UNUSED = &thread_current ()->spt;
	struct page *page = NULL;
	/* spt_find_page 를 거쳐 보조 페이지 테이블을 참고하여 fault된 주소에 대응하는 페이지 구조체를 해결하기 위한
	 함수 vm_try_handle_fault를 수정하세요. */
	
	/* not present 가 false면 readonly 페이지에 write 하려는 상황*/

	/* 할당되지 않은 공간에 접근할 때 */
	
	// if(!spt_find_page(spt,f->rsp) && user){
	// 	vm_stack_growth(f->rsp);
	// 	return true;
	// }

	page = spt_find_page(spt, addr);
	if(!page &&!user)	
		exit(-1);
	/* 유저가 호출하고, 페이지가 없고, 주소값이 스택영역에 해당될 경우 */
	if( user && !page && addr < USER_STACK && addr >= (USER_STACK-0x100000)/*  && (addr > (f->rsp-PGSIZE)) */){
		if( addr <= (f->rsp-PGSIZE))
			exit(-1);
		vm_stack_growth(addr);
		return true;
	}
	else{
		bool ret = vm_do_claim_page(page);
		return ret;
	}
}

/* Free the page.
 * DO NOT MODIFY THIS FUNCTION. */
void
vm_dealloc_page (struct page *page) {
	destroy (page);
	free (page);
}

/* Claim the page that allocate on VA. */
bool
vm_claim_page (void *va /*UNUSED*/) {
    struct page *page = spt_find_page(&thread_current()->spt,va);
    if (page == NULL)
	{
		return false;
	}
	/* spt에 찾는 page가 없으면 어떡함? */
	
	return vm_do_claim_page (page);
}

/* Claim the PAGE and set up the mmu. */
static bool
vm_do_claim_page (struct page *page) {
	struct frame *frame = vm_get_frame ();
    /* Set links */
	if( frame == NULL)
		return false;
    frame->page = page;
    page->frame = frame;
    /* TODO: Insert page table entry to map page's VA to frame's PA. */
	
    // bool succ = install_page(page->va,frame->kva,page->writable);
	bool succ = (pml4_get_page(thread_current()->pml4, page->va) == NULL && pml4_set_page(thread_current()->pml4, page->va, frame->kva, page->writable));
	
    if (!succ){
		return false;
	} 
	return swap_in (page, frame->kva);
}


/* Initialize new supplemental page table
	위의 함수는 보조 페이지 테이블를 초기화합니다. 
	보조 페이지 테이블를 어떤 자료 구조로 구현할지 선택하세요. 
	userprog/process.c의 initd 함수로 새로운 프로세스가 시작하거나 
	process.c의 __do_fork로 자식 프로세스가 생성될 때 위의 함수가 호출됩니다.*/
void
supplemental_page_table_init (struct supplemental_page_table *spt ) {
	spt->hash_vm = malloc(sizeof(struct hash));
	hash_init(spt->hash_vm,page_hash,page_less,NULL);
}

/* Copy supplemental page table from src to dst */
/*해당 함수는 부모 프로세스가 가지고 있는 본인의 SPT 정보를 빠짐없이 자식 프로세스에게 복사해주는 기능을 수행합니다.(fork 시스템 콜)
우선 해시테이블을 통해 구현한 SPT를 iteration해줘야 합니다. 이를 구현하기 위한 방법을 hash.c 파일에서 제공합니다.

이후 iter를 돌 때마다 해당 hash_elem과 연결된 page를 찾아서 해당 페이지 구조체의 정보들을 저장합니다.
페이지 구조체의 어떠한 정보를 저장해야할지 감이 안오신다면 vm_alloc_page_with_initializer()함수의 인자를 참고하시길 바랍니다.

부모 페이지들의 정보를 저장한 뒤,자식이 가질 새로운 페이지를 생성해야합니다.생성을 위해 부모 페이지의 타입을 먼저 검사합니다.
즉,부모 페이지가UNINIT 페이지인 경우와 그렇지 않은 경우를 나누어 페이지를 생성해줘야합니다.

만약 uninit이 아닌 경우 setup_stack()함수에서 했던 것처럼 페이지를 생성한뒤 바로 해당 페이지의 타입에 맞는 initializer를 호출해 페이지 타입을 변경시켜줍니다.
그리고 나서 부모페이지의 물리 메모리 정보를 자식에게도 복사해주어야 합니다.

모든 함수 호출이 정상적으로 이루어졌다면 return true를 하며 함수를 종료합니다.*/
bool
supplemental_page_table_copy (struct supplemental_page_table *dst /*UNUSED*/,
	struct supplemental_page_table *src /*UNUSED*/) {
	struct hash_iterator i;
	hash_first(&i,src->hash_vm);
	while(hash_next(&i)){
		struct page *src_p = hash_entry(hash_cur(&i), struct page ,h_elem);
		enum vm_type src_type = page_get_type(src_p);
	
		/* dst는 thread_current()->spt다  */
		void* upage = src_p->va;
		/* dst에 알아서 struct page를 넣어줌 */

		// vm_alloc_page(src_type,upage,src_p->writable);
		if(!vm_alloc_page_with_initializer(src_p->uninit.type, src_p->va, src_p->writable, src_p->uninit.init, src_p->uninit.aux))
			return false;

		struct page *dst_p = spt_find_page(dst,upage);
		if (src_p ->frame){
			if(!vm_do_claim_page(dst_p)) return false;
			memcpy(dst_p->frame->kva,src_p->frame->kva,PGSIZE); /*물리메모리 정보 복사*/
		}
	}
	return true;
}
/* Free the resource hold by the supplemental page table */
void
supplemental_page_table_kill (struct supplemental_page_table *spt UNUSED) {
	/* TODO: Destroy all the supplemental_page_table hold by thread an
	 * TODO: writeback all the modified contents to the storage. 
	supplemental page table에 의해 유지되던 모든 자원들을 free
	process가 exit할 때(userprog/process.c의 process_exit()) 호출됩니다.
	페이지 엔트리를 반복하면서 테이블의 페이지에 destroy(page)를 호출해야함
	실제 페이지 테이블(pml4)와 물리 주소(palloc된 메모리)에 대해 걱정할 필요가 없다.
	supplemental page table이 정리되어지고 나서, 호출자가 그것들을 정리할 것입니다.*/
	// struct hash_iterator i;
	// hash_first(&i,&src->hash_vm);
	// while(hash_next(&i)){
	// 	struct page *src_p = hash_entry(hash_cur(&i), struct page ,h_elem);
	// 	enum vm_type src_type = page_get_type(src_p);
	// }
	/* struct hash_iterator i;
	hash_first(&i,spt->hash_vm);
	while(hash_next(&i)){
		struct page *page = hash_entry(hash_cur(&i), struct page ,h_elem);
		destroy(page);
	}
	hash_init(spt->hash_vm,page_hash,page_less,NULL); */

	hash_destroy(spt->hash_vm, page_in_hash_free);
}


/* hash_destory에 들어갈estructor */
void page_in_hash_free(struct hash_elem *hash_elem, void* aux){
	struct page* get_page = hash_entry(hash_elem, struct page ,h_elem);
	vm_dealloc_page(get_page);
}

unsigned page_hash( const struct hash_elem *p_, void *aux){
	const struct page *p = hash_entry(p_, struct page, h_elem);
	// return hash_bytes (&p->va, sizeof p->va);
	return hash_int(p->va);
}

bool page_less (const struct hash_elem *a_,
				const struct hash_elem *b_, void *aux ){
	const struct page *a = hash_entry (a_, struct page, h_elem);
	const struct page *b = hash_entry (b_, struct page, h_elem);

	return a->va < b->va;
}