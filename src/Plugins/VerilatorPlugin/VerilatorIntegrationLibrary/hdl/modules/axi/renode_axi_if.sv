//
// Copyright (c) 2010-2023 Antmicro
//
// This file is licensed under the MIT License.
// Full license text is available in 'licenses/MIT.txt'.
//

import renode_axi_pkg::*;

interface renode_axi_if #(
    int unsigned AddressWidth = 32,
    int unsigned DataWidth = 32,
    int unsigned TransactionIdWidth = 8
) (
    input logic clk
);
  localparam int unsigned StrobeWidth = (DataWidth / 8);

  typedef logic [AddressWidth-1:0] address_t;
  typedef logic [DataWidth-1:0] data_t;
  typedef logic [StrobeWidth-1:0] strobe_t;
  typedef logic [TransactionIdWidth-1:0] transaction_id_t;

  logic                  areset_n;
  transaction_id_t       awid;
  address_t              awaddr;
  burst_length_t         awlen;
  burst_size_t           awsize;
  burst_type_t           awburst;
  logic                  awlock;
  logic            [3:0] awcache;
  logic            [2:0] awprot;
  logic                  awvalid;
  logic                  awready;
  data_t                 wdata;
  strobe_t               wstrb;
  logic                  wlast;
  logic                  wvalid;
  logic                  wready;
  transaction_id_t       bid;
  response_t             bresp;
  logic                  bvalid;
  logic                  bready;
  transaction_id_t       arid;
  address_t              araddr;
  burst_length_t         arlen;
  burst_size_t           arsize;
  burst_type_t           arburst;
  logic                  arlock;
  logic            [3:0] arcache;
  logic            [2:0] arprot;
  logic                  arvalid;
  logic                  arready;
  transaction_id_t       rid;
  data_t                 rdata;
  response_t             rresp;
  logic                  rlast;
  logic                  rvalid;
  logic                  rready;

  task static reset_assert();
    areset_n = 0;
    // The reset takes 2 cycles to prevent a race condition without usage of a non-blocking assigment.
    repeat (2) @(posedge clk);
  endtask

  task static reset_deassert();
    areset_n = 1;
    // There is one more wait for the clock edges to be sure that all modules aren't in a reset state.
    repeat (2) @(posedge clk);
  endtask
endinterface

