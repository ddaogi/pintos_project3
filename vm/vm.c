/* vm.c: Generic interface for virtual memory objects. */

#include "threads/malloc.h"
#include "vm/vm.h"
#include "vm/inspect.h"
//hash추가
#include <hash.h>
#include "threads/vaddr.h"
#include "threads/thread.h"
#include "threads/mmu.h"
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
			// init = anon_initializer;
			uninit_new(new_page,upage,init,type,aux,anon_initializer);
		}else if(type == VM_FILE){
			// init = file_backed_initializer;
			uninit_new(new_page,upage,init,type,aux,file_backed_initializer);
		}else{
			return false;
		}
		/* TODO: Insert the page into the spt. */
		spt_insert_page(spt, new_page);
		return true;
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
  	hash_elem = hash_find (&spt->hash_vm, &temp_page->h_elem);
	if (hash_elem == NULL) {
		free(temp_page);
		return NULL;
	}
	free(temp_page);
  	return hash_elem != NULL ? hash_entry (hash_elem, struct page, h_elem) : NULL;

}

/* Insert PAGE into spt with validation. 
	위의 함수는 인자로 주어진 보조 페이지 테이블에 페이지 구조체를 삽입합니다. 
	이 함수에서 주어진 보충 테이블에서 가상 주소가 존재하지 않는지 검사해야 합니다.*/
bool
spt_insert_page (struct supplemental_page_table *spt /*UNUSED*/,
		struct page *page /*UNUSED*/) {
	// int succ = false;
	/* TODO: Fill this function. */
	struct hash_elem *insert_elem = hash_insert(&spt->hash_vm, &page->h_elem);
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

	struct supplemental_page_table *spt UNUSED = &thread_current ()->spt;
	struct page *page = NULL;


	/* spt_find_page 를 거쳐 보조 페이지 테이블을 참고하여 fault된 주소에 대응하는 페이지 구조체를 해결하기 위한
	 함수 vm_try_handle_fault를 수정하세요. */
	
	page = spt_find_page(spt, addr);
	
	// if(page == NULL)
	// 	PANIC("STOP");
	


	/* TODO: Validate the fault */
	/* 진짜 page fault인지, bogus인지 확인하라는 뜻 같음*/

	/* TODO: Your code goes here */
	/* stack growth 함수를 호출해야함? */

	bool ret = vm_do_claim_page(page);
	//PANIC("woohyun22"); /*이게 안나옴*/
	return ret;
	// return vm_do_claim_page (page);
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
    struct page *page = NULL;
	
    page = spt_find_page(&thread_current()->spt,va);
    
	/* spt에 찾는 page가 없으면 어떡함? */
	
	return vm_do_claim_page (page);
}

/* Claim the PAGE and set up the mmu. */
static bool
vm_do_claim_page (struct page *page) {
	struct frame *frame = vm_get_frame ();
    /* Set links */
    frame->page = page;
    page->frame = frame;
    /* TODO: Insert page table entry to map page's VA to frame's PA. */
    // spt_insert_page(thread_current()->spt, page);
		
	
    bool succ = pml4_set_page(thread_current()->pml4,page->va,frame->kva,true);
    if (!succ){
		return false;
	} 
	// swap_in (page, frame->kva);
	return true;
}


/* Initialize new supplemental page table
	위의 함수는 보조 페이지 테이블를 초기화합니다. 
	보조 페이지 테이블를 어떤 자료 구조로 구현할지 선택하세요. 
	userprog/process.c의 initd 함수로 새로운 프로세스가 시작하거나 
	process.c의 __do_fork로 자식 프로세스가 생성될 때 위의 함수가 호출됩니다.*/
void
supplemental_page_table_init (struct supplemental_page_table *spt ) {
	hash_init(&spt->hash_vm,page_hash,page_less,NULL);
}

/* Copy supplemental page table from src to dst */
bool
supplemental_page_table_copy (struct supplemental_page_table *dst /*UNUSED*/,
		struct supplemental_page_table *src /*UNUSED*/) {
	void* new_page;
	vm_alloc_page(VM_UNINIT,new_page,true);
	
	
}

/* Free the resource hold by the supplemental page table */
void
supplemental_page_table_kill (struct supplemental_page_table *spt UNUSED) {
	/* TODO: Destroy all the supplemental_page_table hold by thread and
	 * TODO: writeback all the modified contents to the storage. */
}

unsigned page_hash( const struct hash_elem *p_, void *aux){
	const struct page *p = hash_entry(p_, struct page, h_elem);
	return hash_bytes (&p->va, sizeof p->va);
}

bool page_less (const struct hash_elem *a_,
				const struct hash_elem *b_, void *aux ){
	const struct page *a = hash_entry (a_, struct page, h_elem);
	const struct page *b = hash_entry (b_, struct page, h_elem);

	return a->va < b->va;
}