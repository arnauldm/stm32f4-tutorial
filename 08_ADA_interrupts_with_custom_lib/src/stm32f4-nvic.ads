
-- Nested vectored interrupt controller (NVIC)
-- (see STM32F4xxx Cortex-M4 Programming Manual, p. 194-205)

package stm32f4.nvic is

   -- Up to 81 interrupts (see Cortex-M4 prog. manual, p. 194)
   subtype interrupt is natural range 0 .. 80;

   -- (see RM0090, p. 374)
   EXTI_Line_0 : constant interrupt := 6;

   -------------------------------------------------
   -- Interrupt set-enable registers (NVIC_ISERx) --
   -------------------------------------------------

   type t_interrupt is (IRQ_DISABLED, IRQ_ENABLED) with size => 1;
   for t_interrupt use
     (IRQ_DISABLED => 0,
      IRQ_ENABLED  => 1);

   type t_interrupts is array (interrupt range <>) of t_interrupt
      with pack;

   --
   -- ISER0
   --


   type t_NVIC_ISER0 is record
      irq : t_interrupts(0..31);
   end record
      with pack, size => 32, volatile_full_access;

   --
   -- ISER1
   --

   type t_NVIC_ISER1 is record
      irq : t_interrupts(32..63);
   end record
      with pack, size => 32, volatile_full_access;

   --
   -- ISER2
   --

   type t_NVIC_ISER2 is record
      irq : t_interrupts(64..80);
   end record
      with size => 32, volatile_full_access;

   for t_NVIC_ISER2 use record
      irq at 0 range 0 .. 16;
   end record;

   ----------------------------------------------
   -- Interrupt priority registers (NVIC_IPRx) --
   ----------------------------------------------

   -- NVIC_IPR0-IPR80 registers provide an 8-bit priority field for each
   -- interrupt.

   type t_IPR is record
      reserved : uint4;
      priority : uint4;
   end record
      with pack, size => 8, volatile_full_access;

   type t_IPRs is array (interrupt) of t_IPR
      with pack, size => 8 * 81;

   ----------
   -- NVIC --
   ----------

   type t_NVIC is record
      ISER0 : t_NVIC_ISER0;
      ISER1 : t_NVIC_ISER1;
      ISER2 : t_NVIC_ISER2;
      IPR   : t_IPRs;
   end record;

   for t_NVIC use record
      ISER0 at 16#00# range 0 .. 31;
      ISER1 at 16#04# range 0 .. 31;
      ISER2 at 16#08# range 0 .. 31;
      IPR   at 16#300# range 0 .. (8*81)-1;
   end record;

end stm32f4.nvic;
