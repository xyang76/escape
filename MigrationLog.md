# ======================================
# Popcorn Linux 5.2.21 -> Linux 6.18.52 Migration Logs
# ======================================

Status:
- TODO: Not started
- MISMATCH: Version mismatch, need work out later
- IN PROGRESS: Currently being migrated
- DONE: Migrated and verified

---
# 01. Core / Build / Kconfig: DONE (Sep 18, 2026)
- Description: Popcorn-boot related parts.

# 02. Popcorn Defs:  DONE (Oct 1, 2026)
* Popcorn def folder: popcorn-kernel/include/popcorn
* Task: popcorn-kernel/include/linux/sched.h
* Syscall: popcorn-kernel/include/linux/syscalls.h
    - Description: Xin, added ifdef CONFIG_POPCORN for code robustness
* Syscall: popcorn-kernel/include/uapi/asm-generic/unistd.h
    - Description: seems okay as removed __NR_syscalls 470
* popcorn-kernel/include/uapi/asm-generic/mman-common.h
    - Description: updated MADV_RELEASE value from 20 to 901, since 20 is used for MADV_COLD in linux 6.18
* Page: popcorn-kernel/arch/x86/include/asm/page_64_types.h
    - Description: Popcorn seems used the virtual address space to 38 bits, updated fun: default_map_window
* MM: popcorn-kernel/mm/internal.h
* Memory: popcorn-kernel/include/linux/mm_types.h
* MM: popcorn-kernel/include/linux/mm.h
* Memory: popcorn-kernel/mm/memory.c
    - Description: modified __get_fault_gfp_mask for pass kernel compilation

# 03. Missing Defs: MISMATCH
* popcorn-kernel/arch/x86/include/asm/pgtable-2level.h
* popcorn-kernel/arch/x86/include/asm/pgtable-3level.h
* popcorn-kernel/arch/x86/include/asm/pgtable.h

==> OCT 3, 2026 defs compilation passed. [github version: 2e71026]

# 04. MSG_Layer:  DONE (Oct 4, 2026)
* Msg layer def folder: popcorn-kernel/kernel/msg_layer
    - Description: move the popcorn-kernel/msg_layer to popcorn-kernel/kernel/msg_layer, because Linux 6 no longer support compile core_y style.
    - Description: edited  popcorn-kernel/kernel/Makefile and added the compilation of msg_layer.

# 05. Popcorn Kernel:  IN PROGRESS (Oct 4, 2026)
* TODO: popcorn-kernel/arch/x86/include/asm/pgtable_64.h remove  #include <asm/pgtable-invert.h>
* Stat：popcorn-kernel/kernel/stat.c
    - Description: Linux 6 does not use file_operations for proc_create anymore, replaced with proc_ops instead.
* Sched_server: popcorn-kernel/kernel/sched_server.c
    - Description: Linux 6 does not use file_operations for proc_create anymore, replaced with proc_ops instead.

==> OCT 4, 2026 Msg_layer && pcn_kmsg module compilation pass. [github version: e345233]

* Popcorn nodes module(popcorn_nodes_init) and statistics_init pass.
* Popcorn syscall module: 
  - Description: edited force_sig to send_sig, since force_sig no longer supports task_ptr in Linux 6.
* Syscall_redirect:
  - Description: migrating system calls.

# 05. PageSever / Syscall / ProcessServer:  IN PROGRESS (Oct 19, 2026)

* Popcorn process_server module:
  - Description: edited kernel_thread name to “popremote“
  - Updated: use_mm/force_sig
  - TODO: set_fs(USER_DS) need work out with Linux6

* Popcorn syscall module: 
  - Description: edited force_sig to send_sig, since force_sig no longer supports task_ptr in Linux 6.
* Syscall_redirect:
  - Description: migrating system calls.


* Popcorn page_server module:
#kernel/popcorn/pageserver.c
  - Description: mm->mmap_sem is no longer in use.
  - Replace: down_read(&mm->mmap_sem) => mmap_read_lock(mm)
	up_read(&mm->mmap_sem) =>  mmap_read_unlock(mm)
	down_read_trylock(&mm->mmap_sem) => mmap_read_trylock(mm)
	set_pte_at_notify => set_pte_at
	pte_mkwrite(pte) => pte_mkwrite(pte, vma)
  	mm-mmap iteration => vma_interation instead
  - Further Edition: alloc_set_pte() and 
#mm/memory.c	
 – page_server_zap_pte moved to do_zap_pte_range function to keep same functionality
 – add ifndef wrap for deleted code in remap_pte_range

