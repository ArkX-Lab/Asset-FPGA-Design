`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2025 03:02:34 PM
// Design Name: 
// Module Name: Reset_Basic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Reset_Basic # (
        parameter integer CLK_FREQ  = 125000000,
        parameter integer DLY_MS    = 1
    )
    (
    // General
        input           i_clk,
        input           i_rst_n_src,

    // ======================================================================== //
    //                                 Output                                   //   
    // ======================================================================== //
        output          o_rst_n
    );


// ============================================================================ //
//                                                                              //
//                                 Local Param.                                 //
//                                                                              //
// ============================================================================ //

// ==================================================================== //
//  [1] Local Param. used for Maximum Reset Count Calculation           //
// ==================================================================== //
    localparam  COUNT_1MS   = (CLK_FREQ / 1000);
    localparam  MAX_COUNT   = COUNT_1MS * DLY_MS;

// ============================================================================ //
//                                                                              //
//                                  Wire & Reg                                  //
//                                                                              //
// ============================================================================ //

// ==================================================================== //
//  [1] Variable used for Core                                          //
// ==================================================================== //
    // 1. Variables
    reg [31:0]  rst_count;
    reg         rst_n;

    // 2. Init of Variables
    initial     rst_count   = 0;
    initial     rst_n       = 0;

// ============================================================================ //
//                                                                              //
//                                  Core Logic                                  //
//                                                                              //
// ============================================================================ //

// ==================================================================== //
//  [1] Seq. Logic for Reset Counter                                    //
// ==================================================================== //
    // 1. Reset Count
    always @(posedge i_clk) begin
        if(!i_rst_n_src) begin
            rst_count <= 0;
        end
        else if(rst_count != MAX_COUNT) begin
            rst_count <= rst_count + 1;
        end
    end
    
    // 2. Reset Output
    always @(posedge i_clk) begin
        rst_n <= (rst_count == MAX_COUNT);
    end

// ============================================================================ //
//                                                                              //
//                            Output Port Assignment                            //
//                                                                              //
// ============================================================================ //
    assign  o_rst_n = rst_n;


endmodule
