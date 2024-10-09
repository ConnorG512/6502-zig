const cpu_flag = struct {
    const cpuFlag = enum {
        carry_f,
        zero_f,
        interrupt_f,
        decimal_f,
        break_f,
        unused_f,
        overflow_f,
        negative_f,
    };
};