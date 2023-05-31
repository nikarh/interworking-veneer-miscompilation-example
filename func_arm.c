extern void func_thumb();

void func_arm(int x) {
    asm volatile("" : : "r"(x) : "memory");
    func_thumb();
}
