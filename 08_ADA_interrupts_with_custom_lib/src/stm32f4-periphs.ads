with system;

with stm32f4.rcc;
with stm32f4.syscfg;
with stm32f4.exti;
with stm32f4.gpio;
with stm32f4.nvic;

package stm32f4.periphs is

   --
   -- Base addresses
   --

   NVIC_Base      : constant address := 16#E000_E100#;

   GPIOD_Base     : constant address := 16#4002_0C00#; -- AHB1
   GPIOC_Base     : constant address := 16#4002_0800#; -- AHB1
   GPIOB_Base     : constant address := 16#4002_0400#; -- AHB1
   GPIOA_Base     : constant address := 16#4002_0000#; -- AHB1

   RCC_Base       : constant address := 16#4002_3800#; -- AHB1
   EXTI_Base      : constant address := 16#4001_3C00#; -- APB2
   SYSCFG_Base    : constant address := 16#4001_3800#; -- APB2

   USART6_Base    : constant address := 16#4001_1400#; -- APB2
   UART5_Base     : constant address := 16#4000_5000#; -- APB1
   UART4_Base     : constant address := 16#4000_4C00#; -- APB1
   USART3_Base    : constant address := 16#4000_4800#; -- APB1
   USART2_Base    : constant address := 16#4000_4400#; -- APB1
   USART1_Base    : constant address := 16#4001_1000#; -- APB2

   --
   -- Peripherals
   --

   GPIOA : aliased stm32f4.gpio.t_GPIO_port
      with import, address => system'to_address (GPIOA_Base);
   -- Note: 'import' aspect means that the actual values are defined outside
   -- the application and should not be initialized

   GPIOD    : aliased stm32f4.gpio.t_GPIO_port
      with import, address => system'to_address (GPIOD_Base);

   RCC      : aliased stm32f4.rcc.t_RCC_periph
      with import, address => system'to_address (RCC_Base);

   SYSCFG   : aliased stm32f4.syscfg.t_SYSCFG_periph
      with import, address => system'to_address (SYSCFG_Base);

   EXTI     : aliased stm32f4.exti.t_EXTI_periph
      with import, address => system'to_address (EXTI_Base);

   NVIC     : aliased stm32f4.nvic.t_NVIC
      with import, address => system'to_address (NVIC_Base);

   

   --
   -- Led & buttons
   --

   green_led_pin  : constant stm32f4.gpio.GPIO_pin_index := 12; -- PD12
   orange_led_pin : constant stm32f4.gpio.GPIO_pin_index := 13; -- PD13
   red_led_pin    : constant stm32f4.gpio.GPIO_pin_index := 14; -- PD14
   blue_led_pin   : constant stm32f4.gpio.GPIO_pin_index := 15; -- PD15

   blue_button    : constant stm32f4.gpio.GPIO_pin_index := 0;  -- PA0

end stm32f4.periphs;
