/* anon.c: Implementation of page for non-disk image (a.k.a. anonymous page). */

#include "vm/vm.h"
#include "devices/disk.h"
#include <bitmap.h>
#include "threads/mmu.h"

/* DO NOT MODIFY BELOW LINE */
static struct disk *swap_disk;
static bool anon_swap_in (struct page *page, void *kva);
static bool anon_swap_out (struct page *page);
static void anon_destroy (struct page *page);


/* DO NOT MODIFY this struct */
static const struct page_operations anon_ops = {
	.swap_in = anon_swap_in,
	.swap_out = anon_swap_out,
	.destroy = anon_destroy,
	.type = VM_ANON,
};

/* Initialize the data for anonymous pages  */
void 
vm_anon_init (void) {
	/* TODO: Set up the swap_disk. 
	이 기능에서는 스왑 디스크를 설정해야 합니다. 또한 스왑 디스크에서 사용 가능한 영역과 사용된 영역을 관리하기 위한 데이터 구조가 필요합니다. 
	스왑 영역도 PGSIZE(4096바이트) 단위로 관리됩니다.*/
	swap_disk = disk_get(1,1);
	// int bit_length =disk_size(swap_disk)/ (1<<12);
	int bit_length = disk_size(swap_disk)/8;
	swap_table= bitmap_create(bit_length);
	list_init(&frame_list);
}

/* Initialize the file mapping */
bool
anon_initializer (struct page *page, enum vm_type type, void *kva) {
	/* Set up the handler 
	이것은 익명 페이지의 이니셜라이저입니다. 스와핑을 지원하려면 anon_page에 몇 가지 정보를 추가해야 합니다.*/
	page->operations = &anon_ops;
	// page->frame->kva = kva; //이걸까?
	//음...
	
	//몇가지 정보가 뭔데 그래서
	
	struct anon_page *anon_page = &page->anon;
}

/* Swap in the page by read contents from the swap disk. */
	/* 이제 vm/anon.c에서 anon_swap_in 및 anon_swap_out을 구현하여 익명 페이지에 대한 스와핑을 지원합니다. 
	페이지를 swap in하려면 페이지를 swap out해야 하므로 anon_swap_in을 구현하기 전에 anon_swap_out을 구현하는 것이 좋습니다. 
	데이터 내용을 스왑 디스크로 이동하고 안전하게 메모리로 다시 가져와야 합니다.*/
static bool
anon_swap_in (struct page *page, void *kva) {
	/* 스왑 디스크 데이터 내용을 읽어서 익명 페이지를(디스크에서 메모리로)  swap in합니다. 
	스왑 아웃 될 때 페이지 구조체는 스왑 디스크에 저장되어 있어야 합니다. 스왑 테이블을 업데이트해야 합니다(스왑 테이블 관리 참조). */
	
	for(uintptr_t i = 0 ;i<8;i++){
		disk_read(swap_disk,(page->disk_sec_no)+i,kva+(i*512));
	}
	bitmap_set(swap_table,page->disk_sec_no,false);
	page->is_loaded = 1;
	struct anon_page *anon_page = &page->anon;
	return true;
}

/* Swap out the page by writing contents to the swap disk. */
static bool
anon_swap_out (struct page *page) {
	/* 메모리에서 디스크로 내용을 복사하여 익명 페이지를 스왑 디스크로 교체합니다. 
	먼저 스왑 테이블을 사용하여 디스크에서 사용 가능한 스왑 슬롯을 찾은 다음 데이터 페이지를 슬롯에 복사합니다. 
	데이터의 위치는 페이지 구조체에 저장되어야 합니다. 
	디스크에 사용 가능한 슬롯이 더 이상 없으면 커널 패닉이 발생할 수 있습니다. */
	
	/* 쫓아낼 프레임 갖고와 */
	for(int i =0;i<bitmap_size(swap_table);i++){
		if(bitmap_test(swap_table,i) ==false){
			/* 디스크에 이 idx에 넣어줘야 됨.. */
			// disk_write(swap_disk,i*8,page->frame->kva);
			for(uintptr_t j = 0; j<8;j++){
				disk_write(swap_disk, i*8+j, page->frame->kva+(j*512));
			}
			pml4_clear_page(page->frame->thread->pml4,page->va);
			bitmap_set(swap_table,i,true);
			page->disk_sec_no = i*8;
			page->frame->page = NULL;
			page->frame = NULL;
			page->is_loaded = 0;
			break;
		}
	}

	struct anon_page *anon_page = &page->anon;
	return true;
}

/* Destroy the anonymous page. PAGE will be freed by the caller. */
static void
anon_destroy (struct page *page) {
	struct anon_page *anon_page = &page->anon;
}
