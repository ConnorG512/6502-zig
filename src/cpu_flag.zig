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

    // Set flags for functions
    // flag 5 is unused in 6502 and will always be set to the value of 1
    fn setAllFlags(self: *CPU) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in setAllFlags() !");
            return CPUError.null_cpu_ref;
        }
        
        self.RP = 0b1_1_1_1_1_1_1_1;
    }

    fn setFlag(self: *CPU) !void {

        if (self == null) {
            logging.errorLog("Error: CPU null reference in setFlag() !");
            return CPUError.null_cpu_ref;
        }

        switch (self.cpuFlag) {
            cpuflag.carry_f => {

            } 

        }
    }
    
    fn clearAllFlags (self: *CPU) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearAllFlags() !");
            return CPUError.null_cpu_ref;
        }

        self.RP = 0b0_0_0_0_1_0_0_0;
    }

    fn clearFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearFlag() !");
            return CPUError.null_cpu_ref;
        }
        
        if (flag > 0b1_1_1_1_1_1_1_1) {
            logging.errorLog("Error: Flag overflow in clearFlag() !");
            return CPUError.cpu_flag_overflow;
        }

        // bitwise and (&) not (~) operation to set the respective bits to 0
        self.RP &= ~flag;
    }
};