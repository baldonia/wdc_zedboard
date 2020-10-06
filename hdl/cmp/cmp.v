//////////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Mon May  5 14:20:26 EDT 2014
// cmp.v
// 14-bit magnitude comparator with select lines for the appropriate trigger
// condition.
// Purely combinational
//
// Adapted by A. Fienberg for the mDOM project (changed to 12 bits)
// Aug 2020
//
// May need to be further adapted for signed ADC values
//////////////////////////////////////////////////////////////////////////////////////   
`timescale 1ns / 100ps

module cmp
  (
   input [11:0] a,
   input [11:0] b,
   input gt, // select A > B
   input lt, // select A < B
   input et, // select A = B
   output y
   );

   assign y = ((a > b) && gt) || ((a == b) && et) || ((a < b) && lt);

endmodule // cmp

   
