/* file.c: Implementation of memory backed file object (mmaped object). */

#include "vm/vm.h"
#include "userprog/process.h"
#include "threads/vaddr.h"
#include "userprog/syscall.h"
#include "threads/mmu.h"

static bool file_backed_swap_in (struct page *page, void *kva);
static bool file_backed_swap_out (struct page *page);
static void file_backed_destroy (struct page *page);

/* DO NOT MODIFY this struct */
static const struct page_operations file_ops = {
	.swap_in = file_backed_swap_in,
	.swap_out = file_backed_swap_out,
	.destroy = file_backed_destroy,
	.type = VM_FILE,
};

/* The initializer of file vm */
void
vm_file_init (void) {
}

/* Initialize the file backed page */
bool
file_backed_initializer (struct page *page, enum vm_type type, void *kva) {
	/* Set up the handler */
	page->operations = &file_ops;

	struct file_page *file_page = &page->file;
}

/* Swap in the page by read contents from the file. */
static bool
file_backed_swap_in (struct page *page, void *kva) {
	struct file_page *file_page UNUSED = &page->file;
	struct aux_struct* container = page->uninit.aux;
	file_read_at(container->file,page->va,container->page_read_bytes,container->offset);
	return true;
}

/* Swap out the page by writeback contents to the file. */
static bool
file_backed_swap_out (struct page *page) {
	struct file_page *file_page UNUSED = &page->file;
	 if (page == NULL) {
            return;
        }
        struct aux_struct* container = page->uninit.aux;
        if(container->file == NULL) return;
        // file_reopen(container->file);
        if(pml4_is_dirty(thread_current()->pml4,page->va)){
			lock_acquire(&filesys_lock);
			file_seek(container->file, container->offset);
            file_write_at(container->file, page->va, container->page_read_bytes, container->offset);
			lock_release(&filesys_lock);
			pml4_set_dirty(thread_current()->pml4,page->va,0);
        }
        pml4_clear_page(thread_current()->pml4,page->va);
	return true;
}

/* Destory the file backed page. PAGE will be freed by the caller. */
static void
file_backed_destroy (struct page *page) {
	struct file_page *file_page UNUSED = &page->file;
}

/* Do the mmap 
*/
void *
do_mmap (void *addr, size_t length, int writable, struct file *file, off_t offset) {
	
	struct file *re_file = file_reopen(file);
	if (re_file ==NULL){
		return NULL;
	}
	// uint32_t read_bytes = file_length(re_file);
	uint32_t read_bytes = file_length(re_file);
	void* init_addr = addr;
	void* upage = addr;
		
	while(read_bytes > 0 /* || zero_bytes >0 */){
		
		size_t page_read_bytes = read_bytes < PGSIZE ? read_bytes : PGSIZE;

		struct aux_struct* aux = malloc(sizeof(struct aux_struct));
		aux->file = re_file;
		aux->offset = offset;
		aux->page_read_bytes = page_read_bytes;
		aux->init_addr = init_addr;
      	// size_t page_zero_bytes = PGSIZE - page_read_bytes;
		
		vm_alloc_page_with_initializer(VM_FILE, upage, writable, lazy_load_segment, aux);
		
		// vm_claim_page(upage);
		read_bytes -= page_read_bytes;
      	// zero_bytes -= page_zero_bytes;
      	offset+= page_read_bytes;
      	upage += PGSIZE;
	
	}
	return init_addr;
}

/* Do the munmap */
void
do_munmap (void *addr) {
	struct file *return_file ;
    while(true){
        struct page* temp_p = spt_find_page(&thread_current()->spt,addr);
        if (temp_p == NULL) {
            return;
        }
        struct aux_struct* container = temp_p->uninit.aux;
        if(container->file == NULL) return;
        // file_reopen(container->file);
		return_file = container->file;
        if(pml4_is_dirty(thread_current()->pml4,addr)){
			lock_acquire(&filesys_lock);
			file_seek(container->file, container->offset);
            file_write_at(container->file, addr, container->page_read_bytes, container->offset);
			lock_release(&filesys_lock);
			pml4_set_dirty(thread_current()->pml4,addr,0);
        }
        pml4_clear_page(thread_current()->pml4,addr);
        // file_close(container->file);
        addr+= PGSIZE;
	}
	// file_close(return_file);
}