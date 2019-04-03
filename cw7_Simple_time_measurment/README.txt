by Adam Drawc 2019 April

This code was made as the 7th assignment to do in the IUP class.

This project was meant to measure time with a 0,01s resolution.
Each press of the BTN0 button results in an action taking place.
Those actions are START->STOP->RESET
Time representation is : SS.DD (SS-seconds; DD-fractions of a second)

If the timer goes over 59.99 seconds it will display "--.--".

BTN3 acts as an external asynchronous reset.

Buttons are debounced. Since time measurments require immidiate reaction to the button press. Debouncing is done 
in a way that only if after a given period of time signal is still jittering then whole attempt 
for measuring will reset by itself as to assure that only the proper BUTTON PRESS is recognizable.

This project is intended for studying only.
Made to comply with a Digilent Spartan-3 development board with a Spartan-3 3S200 FT256-4 FPGA.