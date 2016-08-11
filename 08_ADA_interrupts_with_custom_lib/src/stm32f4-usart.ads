
package stm32f4.usart is

   --------------------------------
   -- Status register (USART_SR) --
   --------------------------------

   type t_USART_SR is record
      PE    : bit;   -- Parity error
      FE    : bit;   -- Framing error
      NF    : bit;   -- Noise detected flag
      ORE   : bit;   -- Overrun error
      IDLE  : bit;   -- IDLE line detected
      RXNE  : bit;   -- Read data register not empty
      TC    : bit;   -- Transmission complete
      TXE   : bit;   -- Transmit data register empty
      LBD   : bit;   -- LIN break detection flag
      CTS   : bit;   -- CTS flag
      reserved_10_15 : uint6;
      reserved_16_31 : short;
   end record
      with pack, size => 32, volatile_full_access;

   ------------------------------
   -- Data register (USART_DR) --
   ------------------------------

   type t_USART_DR is record
      -- Data value that contains the Received or Transmitted data character,
      -- depending on whether it is read from or written to.
      DR : uint9; 
   end record
      with size => 32, volatile_full_access;

   for t_USART_DR use record
      DR at 0 range 0 .. 8;
   end record;
   
   ------------------------------------
   -- Baud rate register (USART_BRR) -- 
   ------------------------------------

   type t_USART_BRR is record
      DIV_Fraction   : uint4;
      DIV_Mantissa   : uint12;
      reserved_16_31 : short;
   end record
      with pack, size => 32, volatile_full_access;

   ------------------------------------
   -- Control register 1 (USART_CR1) --
   ------------------------------------

   type t_USART_CR1 is record
      SBK         : bit;   -- Send break
      RWU         : bit;   -- Receiver wakeup
      RE          : bit;   -- Receiver enable
      TE          : bit;   -- Transmitter enable
      IDLEIE      : bit;   -- IDLE interrupt enable
      RXNEIE      : bit;   -- RXNE interrupt enable
      TCIE        : bit;   -- Transmission complete interrupt enable
      TXEIE       : bit;   -- TXE interrupt enable
      PEIE        : bit;   -- PE interrupt enable
      PS          : bit;   -- Parity selection
      PCE         : bit;   -- Parity control enable
      WAKE        : bit;   -- Wakeup method
      M           : bit;   -- Word length
                           -- 0: 1 Start bit, 8 Data bits, n Stop bit
                           -- 1: 1 Start bit, 9 Data bits, n Stop bit
      UE          : bit;   -- USART enable
      reserved_14 : bit; 
      OVER8       : bit;   -- Oversampling mode
      reserved_16_31 : short;
   end record
      with pack, size => 32, volatile_full_access;
   
   ------------------------------------
   -- Control register 2 (USART_CR2) --
   ------------------------------------

   type t_stop_bits is (STOP_1, STOP_0_dot_5, STOP_2, STOP_1_dot_5)
      with size => 2;
   for t_stop_bits use
     (STOP_1         => 2#00#,
      STOP_0_dot_5   => 2#01#,
      STOP_2         => 2#10#,
      STOP_1_dot_5   => 2#11#);

   type t_USART_CR2 is record
      ADD            : uint4;
         -- Address of the USART node (used in multiprocessor communication
         -- during mute mode, for wake up with address mark detection).
      reserved_4     : bit;
      LBDL           : bit;   -- LIN break detection length
      LBDIE          : bit;   -- LIN break detection interrupt enable
      reserved_7     : bit;
      LBCL           : bit;   -- Last bit clock pulse
      CPHA           : bit;   -- Clock phase
      CPOL           : bit;   -- Clock polarity
      CLKEN          : bit;   -- Clock enable
      STOP           : t_stop_bits;
      LINEN          : bit;   -- LIN mode enable
      reserved_15    : bit;
      reserved_16_31 : short;
   end record
      with pack, size => 32, volatile_full_access;
   
   ------------------------------------
   -- Control register 3 (USART_CR3) --
   ------------------------------------
   -- TODO

   ----------------------------------------------------
   -- Guard time and prescaler register (USART_GTPR) -- 
   ----------------------------------------------------
   -- TODO

   ----------------------
   -- USART Peripheral -- 
   ----------------------

   type t_USART is record
      SR    : t_USART_SR;
      DR    : t_USART_DR;
      BRR   : t_USART_BRR;
      CR1   : t_USART_CR1;
      CR2   : t_USART_CR2;
      USART_CR3   : word;
      USART_GTPR  : word;
   end record;

   for t_USART use record
      SR          at 16#00# range 0 .. 31;
      DR          at 16#04# range 0 .. 31;
      BRR         at 16#08# range 0 .. 31;
      CR1         at 16#0C# range 0 .. 31;
      CR2         at 16#10# range 0 .. 31;
      USART_CR3   at 16#14# range 0 .. 31;
      USART_GTPR  at 16#18# range 0 .. 31;
   end record;


end stm32f4.usart;
