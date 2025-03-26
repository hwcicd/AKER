// Based on file authored by Andres Meza

`timescale 1 ns / 1 ps

`define NUM_RAND_TEST_ROUNDS 4

`define HW_NUM_R_TRANS 4
`define HW_NUM_W_TRANS 4

`define HW_W_BURST_SIZE 8
`define HW_R_BURST_SIZE 8

`define HW_R_BASE_ADDR  'h30000000
`define HW_W_BASE_ADDR  'ha0000000

`define AC_R_LOW_ADDR_1   16'h2000
`define AC_R_HIGH_ADDR_1  16'h4000
`define AC_R_LOW_ADDR_2   16'h7000
`define AC_R_HIGH_ADDR_2  16'ha000

`define AC_W_LOW_ADDR_1   16'h0000
`define AC_W_HIGH_ADDR_1  16'hb000
`define AC_W_LOW_ADDR_2   16'hc000
`define AC_W_HIGH_ADDR_2  16'hf000

`define READ_TEST       1
`define WRITE_TEST      1

`define ILL_TRANS       0

`define ENABLED_REGIONS 32'hffffffff    // | 31 W REGIONS 16 | 15 R REGIONS 0 |

module test();

  localparam integer C_S_AXI_DATA_WIDTH	= 32;
  localparam integer C_S_AXI_ADDR_WIDTH = 8;

  localparam integer C_M_AXI_BURST_LEN    = 16;
  localparam integer C_M_AXI_ID_WIDTH     = 1;
  localparam integer C_M_AXI_ADDR_WIDTH   = 32;
  localparam integer C_M_AXI_DATA_WIDTH   = 32;
  localparam integer C_M_AXI_ARUSER_WIDTH = 1;
  localparam integer C_M_AXI_AWUSER_WIDTH = 1;
  localparam integer C_M_AXI_WUSER_WIDTH  = 1;
  localparam integer C_M_AXI_RUSER_WIDTH  = 1;
  localparam integer C_M_AXI_BUSER_WIDTH  = 1;

  logic                                tb_aclk = 0;
  logic                                tb_aresetn = 1;
  logic                                tb_done = 0;
  logic                                tb_intr_line_r;
  logic                                tb_intr_line_w;

  logic [C_S_AXI_ADDR_WIDTH-1 : 0]     tb_s_axi_awaddr = 0;
  logic [2 : 0]                        tb_s_axi_awprot;
  logic                                tb_s_axi_awvalid = 0;
  logic                                tb_s_axi_awready;

  logic [C_S_AXI_DATA_WIDTH-1 : 0]     tb_s_axi_wdata = 0;
  logic [(C_S_AXI_DATA_WIDTH/8)-1 : 0] tb_s_axi_wstrb = 0;
  logic                                tb_s_axi_wvalid = 0;
  logic                                tb_s_axi_wready;

  logic [1 : 0]                        tb_s_axi_bresp;
  logic                                tb_s_axi_bvalid;
  logic                                tb_s_axi_bready;

  logic [C_S_AXI_ADDR_WIDTH-1 : 0]     tb_s_axi_araddr = 0;
  logic [2 : 0]                        tb_s_axi_arprot;
  logic                                tb_s_axi_arvalid = 0;
  logic                                tb_s_axi_arready;

  logic [C_S_AXI_DATA_WIDTH-1 : 0]     tb_s_axi_rdata;
  logic [1 : 0]                        tb_s_axi_rresp;
  logic                                tb_s_axi_rvalid;
  logic                                tb_s_axi_rready;

  logic [C_M_AXI_ID_WIDTH-1 : 0]       tb_m_axi_awid;
  logic [C_M_AXI_ADDR_WIDTH-1 : 0]     tb_m_axi_awaddr;
  logic [7 : 0]                        tb_m_axi_awlen;
  logic [2 : 0]                        tb_m_axi_awsize;
  logic [1 : 0]                        tb_m_axi_awburst;
  logic                                tb_m_axi_awlock;
  logic [3 : 0]                        tb_m_axi_awcache;
  logic [2 : 0]                        tb_m_axi_awprot;
  logic [3 : 0]                        tb_m_axi_awqos;
  logic [C_M_AXI_AWUSER_WIDTH-1 : 0]   tb_m_axi_awuser;
  logic                                tb_m_axi_awvalid;
  logic                                tb_m_axi_awready;

  logic [C_M_AXI_DATA_WIDTH-1 : 0]     tb_m_axi_wdata;
  logic [(C_M_AXI_DATA_WIDTH/8)-1 : 0] tb_m_axi_wstrb;
  logic                                tb_m_axi_wlast;
  logic [C_M_AXI_WUSER_WIDTH-1 : 0]    tb_m_axi_wuser;
  logic                                tb_m_axi_wvalid;
  logic                                tb_m_axi_wready;

  logic [C_M_AXI_ID_WIDTH-1 : 0]       tb_m_axi_bid    = 0;
  logic [1 : 0]                        tb_m_axi_bresp  = 0;
  logic [C_M_AXI_BUSER_WIDTH-1 : 0]    tb_m_axi_buser  = 0;
  logic                                tb_m_axi_bvalid = 0;
  logic                                tb_m_axi_bready;

  logic [C_M_AXI_ID_WIDTH-1 : 0]       tb_m_axi_arid;
  logic [C_M_AXI_ADDR_WIDTH-1 : 0]     tb_m_axi_araddr;
  logic [7 : 0]                        tb_m_axi_arlen;
  logic [2 : 0]                        tb_m_axi_arsize;
  logic [1 : 0]                        tb_m_axi_arburst;
  logic                                tb_m_axi_arlock;
  logic [3 : 0]                        tb_m_axi_arcache;
  logic [2 : 0]                        tb_m_axi_arprot;
  logic [3 : 0]                        tb_m_axi_arqos;
  logic [C_M_AXI_ARUSER_WIDTH-1 : 0]   tb_m_axi_aruser;
  logic                                tb_m_axi_arvalid;
  logic                                tb_m_axi_arready;

  logic [C_M_AXI_ID_WIDTH-1 : 0]       tb_m_axi_rid    = 0;
  logic [C_M_AXI_DATA_WIDTH-1 : 0]     tb_m_axi_rdata  = 0;
  logic [1 : 0]                        tb_m_axi_rresp  = 0;
  logic                                tb_m_axi_rlast  = 0;
  logic [C_M_AXI_RUSER_WIDTH-1 : 0]    tb_m_axi_ruser  = 0;
  logic                                tb_m_axi_rvalid = 0;
  logic                                tb_m_axi_rready;

  logic                                tb_HW_r_start = 0;
  logic                                tb_HW_w_start = 0;
  logic                                tb_HW_reset   = 0; 
  logic [31:0]                         tb_HW_r_base_addr = 0;
  logic [31:0]                         tb_HW_w_base_addr = 0;
  logic [15:0]                         tb_HW_r_num_trans;
  logic [15:0]                         tb_HW_w_num_trans;
  
  logic [7:0]                          tb_HW_r_burst_len;
  logic [7:0]                          tb_HW_w_burst_len;
  logic                                tb_HW_data_val;
  //-- output done
  logic                                tb_HW_w_done;
  logic                                tb_HW_r_done;
  
  logic                                tb_illegal;
  logic                                tb_init_flag;


  logic tb_i_config = 0;
  logic [31 : 0] tb_o_data; 

  acw #(
    .C_S_CTRL_AXI(32),
    .C_S_CTRL_AXI_ADDR_WIDTH(8)
  )
  u0 (
    .ACLK               (tb_aclk),
    .ARESETN            (tb_aresetn),
    .INTR_LINE_R        (tb_intr_line_r),
    .INTR_LINE_W        (tb_intr_line_w),

    .r_start_wire       (tb_HW_r_start),
    .w_start_wire       (tb_HW_w_start),
    .reset_wire         (tb_HW_reset), 
    .r_base_addr_wire   (tb_HW_r_base_addr),
    .w_base_addr_wire   (tb_HW_w_base_addr),

    .r_num_trans_wire   (tb_HW_r_num_trans),
    .w_num_trans_wire   (tb_HW_w_num_trans),
    
    .r_burst_len_wire   (tb_HW_r_burst_len),
    .w_burst_len_wire   (tb_HW_w_burst_len),
    .data_val_wire      (tb_HW_data_val),

    .w_done_wire        (tb_HW_w_done),
    .r_done_wire        (tb_HW_r_done),

    .S_AXI_CTRL_AWADDR  (tb_s_axi_awaddr),
    .S_AXI_CTRL_AWPROT  (tb_s_axi_awprot),
    .S_AXI_CTRL_AWVALID (tb_s_axi_awvalid),
    .S_AXI_CTRL_AWREADY (tb_s_axi_awready),

    .S_AXI_CTRL_WDATA   (tb_s_axi_wdata),
    .S_AXI_CTRL_WSTRB   (tb_s_axi_wstrb),
    .S_AXI_CTRL_WVALID  (tb_s_axi_wvalid),
    .S_AXI_CTRL_WREADY  (tb_s_axi_wready),

    .S_AXI_CTRL_BRESP   (tb_s_axi_bresp),
    .S_AXI_CTRL_BVALID  (tb_s_axi_bvalid),
    .S_AXI_CTRL_BREADY  (tb_s_axi_bready),

    .S_AXI_CTRL_ARADDR  (tb_s_axi_araddr),
    .S_AXI_CTRL_ARPROT  (tb_s_axi_arprot),
    .S_AXI_CTRL_ARVALID (tb_s_axi_arvalid),
    .S_AXI_CTRL_ARREADY (tb_s_axi_arready),

    .S_AXI_CTRL_RDATA   (tb_s_axi_rdata),
    .S_AXI_CTRL_RRESP   (tb_s_axi_rresp),
    .S_AXI_CTRL_RVALID  (tb_s_axi_rvalid),
    .S_AXI_CTRL_RREADY  (tb_s_axi_rready),

    .M_AXI_AWID         (tb_m_axi_awid),
    .M_AXI_AWADDR       (tb_m_axi_awaddr),
    .M_AXI_AWLEN        (tb_m_axi_awlen),
    .M_AXI_AWSIZE       (tb_m_axi_awsize),
    .M_AXI_AWBURST      (tb_m_axi_awburst),
    .M_AXI_AWLOCK       (tb_m_axi_awlock),
    .M_AXI_AWCACHE      (tb_m_axi_awcache),
    .M_AXI_AWPROT       (tb_m_axi_awprot),
    .M_AXI_AWQOS        (tb_m_axi_awqos),
    .M_AXI_AWUSER       (tb_m_axi_awuser),
    .M_AXI_AWVALID      (tb_m_axi_awvalid),
    .M_AXI_AWREADY      (tb_m_axi_awready),

    .M_AXI_WDATA        (tb_m_axi_wdata),
    .M_AXI_WSTRB        (tb_m_axi_wstrb),
    .M_AXI_WLAST        (tb_m_axi_wlast),
    .M_AXI_WUSER        (tb_m_axi_wuser),
    .M_AXI_WVALID       (tb_m_axi_wvalid),
    .M_AXI_WREADY       (tb_m_axi_wready),

    .M_AXI_BID          (tb_m_axi_bid),
    .M_AXI_BRESP        (tb_m_axi_bresp),
    .M_AXI_BUSER        (tb_m_axi_buser),
    .M_AXI_BVALID       (tb_m_axi_bvalid),
    .M_AXI_BREADY       (tb_m_axi_bready),

    .M_AXI_ARID         (tb_m_axi_arid),
    .M_AXI_ARADDR       (tb_m_axi_araddr),
    .M_AXI_ARLEN        (tb_m_axi_arlen),
    .M_AXI_ARSIZE       (tb_m_axi_arsize),
    .M_AXI_ARBURST      (tb_m_axi_arburst),
    .M_AXI_ARLOCK       (tb_m_axi_arlock),
    .M_AXI_ARCACHE      (tb_m_axi_arcache),
    .M_AXI_ARPROT       (tb_m_axi_arprot),
    .M_AXI_ARQOS        (tb_m_axi_arqos),
    .M_AXI_ARUSER       (tb_m_axi_aruser),
    .M_AXI_ARVALID      (tb_m_axi_arvalid),
    .M_AXI_ARREADY      (tb_m_axi_arready),

    .M_AXI_RID          (tb_m_axi_rid),
    .M_AXI_RDATA        (tb_m_axi_rdata),
    .M_AXI_RRESP        (tb_m_axi_rresp),
    .M_AXI_RLAST        (tb_m_axi_rlast),
    .M_AXI_RUSER        (tb_m_axi_ruser),
    .M_AXI_RVALID       (tb_m_axi_rvalid),
    .M_AXI_RREADY       (tb_m_axi_rready),

    .i_config           (tb_i_config),
    .o_data             (tb_o_data)
  );

// ------------------- RESET THE DUT
  task reset_dut();
    repeat (4) #10;
    tb_HW_reset <= 1;
    tb_aresetn <= 0;
    repeat (4) #10;
    tb_HW_reset <= 0;
    tb_aresetn <= 1;
    #10;
  endtask : reset_dut
// ----------------END RESET THE DUT

  task test_round();
      reset_dut();

      $display("[ACW_tb] \ttb_HW_r_base_addr = %h", tb_HW_r_base_addr);
      $display("[ACW_tb] \ttb_HW_w_base_addr = %h", tb_HW_w_base_addr);

      repeat (4) @(posedge tb_aclk);

    //------------------ INITIAL CONFIGURATION
      tb_m_axi_rid    <= 0;
      tb_m_axi_rdata  <= 0;
      tb_m_axi_rresp  <= 0;
      tb_m_axi_rlast  <= 0;
      tb_m_axi_ruser  <= 0;
      tb_m_axi_rvalid <= 0;

      tb_m_axi_bid    <= 0;
      tb_m_axi_bresp  <= 0;
      tb_m_axi_buser  <= 0;
      tb_m_axi_bvalid <= 0;

      tb_init_flag    <= 1;
    //---------------END INITIAL CONFIGURATION

    //------------------ CONFIGURE THE ACCESS CONTROL: READ LOWER & UPPER BOUND

      tb_s_axi_awaddr <= {6'h06, 2'b00};
      tb_s_axi_awvalid <= 1;

      repeat (2) @(posedge tb_aclk);

      tb_s_axi_wdata <= {`AC_R_HIGH_ADDR_1, `AC_R_LOW_ADDR_1};
      tb_s_axi_wstrb <= 4'hf;
      tb_s_axi_wvalid <= 1;

      @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
      tb_s_axi_awvalid <= 0;
      tb_s_axi_wvalid <= 0;



      tb_s_axi_awaddr <= {6'h0a, 2'b00};
      tb_s_axi_awvalid <= 1;

      repeat (2) @(posedge tb_aclk);

      tb_s_axi_wdata <= {`AC_R_HIGH_ADDR_2, `AC_R_LOW_ADDR_2};
      tb_s_axi_wstrb <= 4'hf;
      tb_s_axi_wvalid <= 1;

      @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
      tb_s_axi_awvalid <= 0;
      tb_s_axi_wvalid <= 0;
    //---------------END CONFIGURE THE ACCESS CONTROL: READ LOWER & UPPER BOUND

    //------------------ CONFIGURE THE ACCESS CONTROL: WRITE LOWER & UPPER BOUND

      tb_s_axi_awaddr <= {6'h16, 2'b00};
      tb_s_axi_awvalid <= 1;

      repeat (2) @(posedge tb_aclk);

      tb_s_axi_wdata <= {`AC_W_HIGH_ADDR_1, `AC_W_LOW_ADDR_1};
      tb_s_axi_wstrb <= 4'hf;
      tb_s_axi_wvalid <= 1;

      @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
      tb_s_axi_awvalid <= 0;
      tb_s_axi_wvalid <= 0;


      tb_s_axi_awaddr <= {6'h19, 2'b00};
      tb_s_axi_awvalid <= 1;

      repeat (2) @(posedge tb_aclk);

      tb_s_axi_wdata <= {`AC_W_HIGH_ADDR_2, `AC_W_LOW_ADDR_2};
      tb_s_axi_wstrb <= 4'hf;
      tb_s_axi_wvalid <= 1;

      @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
      tb_s_axi_awvalid <= 0;
      tb_s_axi_wvalid <= 0;

    //---------------END CONFIGURE THE ACCESS CONTROL: WRITE LOWER & UPPER BOUND

    //------------------ ENABLE REGIONS

      tb_s_axi_awaddr <= {6'h00, 2'b00};
      tb_s_axi_awvalid <= 1;

      repeat (2) @(posedge tb_aclk);

      tb_s_axi_wdata <= `ENABLED_REGIONS; 
      tb_s_axi_wstrb <= 4'hf;
      tb_s_axi_wvalid <= 1;

      @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
      tb_s_axi_awvalid <= 0;
      tb_s_axi_wvalid <= 0;

    //---------------END ENABLE REGIONS

    //------------------ READ TEST
    if(`READ_TEST)
      begin
        tb_HW_r_start <= 1;

        repeat (10) @(posedge tb_aclk);

        for(int i = 0; i < `HW_NUM_R_TRANS; i++)
          begin
            if(tb_intr_line_r)
              begin 
                $display("[ACW_tb] \tinto illegal read trans");

                tb_illegal <= 1;
                @(posedge tb_aclk && tb_intr_line_r );  
                repeat (5) @(posedge tb_aclk);
                // read the anomaly register


                // reset the anomaly
                tb_s_axi_awaddr  <= {6'h01, 2'b00};
                tb_s_axi_awvalid <= 1;

                repeat (2) @(posedge tb_aclk);

                tb_s_axi_wdata  <= 1'b1;
                tb_s_axi_wstrb  <= 4'hf;
                tb_s_axi_wvalid <= 1;

                @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
                tb_s_axi_awvalid <= 0;
                tb_s_axi_wvalid  <= 0; 

              end      
            else 
              begin 
                $display("[ACW_tb] \tinto legal read trans");

          	tb_illegal <= 0;
                @(posedge tb_aclk && (~tb_init_flag || (tb_m_axi_arvalid && tb_m_axi_arready)));
                tb_init_flag <= 0;
                repeat (10) @(posedge tb_aclk);
                tb_m_axi_rdata <= i;
                tb_m_axi_rresp <= 0;
                tb_m_axi_rvalid <= 1;
                repeat (`HW_R_BURST_SIZE-1) @(posedge tb_aclk && tb_m_axi_rvalid == 1 && tb_m_axi_rready == 1);
                tb_m_axi_rlast <= 1;
                repeat (2) @(posedge tb_aclk && tb_m_axi_rvalid == 1 && tb_m_axi_rready == 1 && tb_m_axi_rlast == 1);
                tb_m_axi_rvalid <= 0;
                tb_m_axi_rlast <= 0;
              end
          end
	  tb_HW_r_start <= 0;
      end
    //---------------END READ TEST

    //------------------ WRITE TEST
    if(`WRITE_TEST)
      begin
        tb_HW_w_start <= 1;

        repeat (10) @(posedge tb_aclk);

        for(int i = 0; i < `HW_NUM_W_TRANS; i++)
          begin 
            if(tb_intr_line_w) 
              begin // illegal transaction
                $display("[ACW_tb] \tinto illegal write trans");
                tb_illegal <= 1;

                @(posedge tb_aclk && tb_intr_line_w );
                repeat (5) @(posedge tb_aclk);
                // read the anomaly register


                // reset the anomaly
                tb_s_axi_awaddr  <= {6'h01, 2'b00};
                tb_s_axi_awvalid <= 1;

                repeat (2) @(posedge tb_aclk);

                tb_s_axi_wdata  <= 2'b10;
                tb_s_axi_wstrb  <= 4'hf;
                tb_s_axi_wvalid <= 1;

                @(tb_s_axi_wvalid == 1 && tb_s_axi_awvalid == 1 && tb_s_axi_bvalid == 1);
                tb_s_axi_awvalid <= 0;
                tb_s_axi_wvalid  <= 0;
              end
            else 
              begin
                $display("[ACW_tb] \tinto legal write trans");
                tb_illegal <= 0;

                @(posedge tb_aclk && tb_m_axi_wvalid && tb_m_axi_wready && tb_m_axi_wlast);
                repeat (5) @(posedge tb_aclk); 
                tb_m_axi_bvalid <= 1;
                repeat (2) @(posedge tb_aclk && tb_m_axi_bvalid);
                tb_m_axi_bvalid <= 0;
              end
          end
	  tb_HW_w_start <= 0;
      end
    //---------------END WRITE TEST
  endtask

//-------------------- CLK PROCESS
  initial begin
			$dumpfile("testbench.vcd");
			$dumpvars(0, test);
      while (!tb_done) begin
          tb_aclk <= 1;
          #(10/2);
          tb_aclk <= 0;
          #(10/2);
      end
      $stop;
  end
//-----------------END CLK PROCESS

//-------------------- STATIC CONF TESTBENCH (MOCK MEMORY AND MOCK PROCESSOR)
  assign tb_s_axi_arprot  = 0;
  assign tb_s_axi_awprot  = 0;
  assign tb_s_axi_bready  = 1;
  assign tb_s_axi_rready  = 1;

  assign tb_m_axi_awready = 1;
  assign tb_m_axi_arready = 1;
  assign tb_m_axi_wready  = 1;

//-----------------END STATIC CONF TESTBENCH (MOCK MEMORY AND MOCK PROCESSOR)

//-------------------- HW STATIC CONFIGURATION
  //assign tb_HW_r_base_addr = `HW_R_BASE_ADDR;
  //assign tb_HW_w_base_addr = `HW_W_BASE_ADDR;

  assign tb_HW_r_num_trans = `HW_NUM_R_TRANS;
  assign tb_HW_w_num_trans = `HW_NUM_W_TRANS;

  assign tb_HW_r_burst_len = `HW_R_BURST_SIZE;
  assign tb_HW_w_burst_len = `HW_W_BURST_SIZE;

  assign tb_HW_data_val    = 1;
  
//-----------------END HW STATIC CONFIGURATION

//-------------------- TEST
  initial begin
    
    for(int i = 0; i < `NUM_RAND_TEST_ROUNDS; i++)
      begin 
        $display("[ACW_tb] Round %d of %d", i+1, `NUM_RAND_TEST_ROUNDS);
        test_round();
      end

    tb_i_config <= 1'b0;

    repeat (10) @(posedge tb_aclk);

    tb_i_config <= 1'b1;

    repeat (5) @(posedge tb_aclk);
    $finish;
  end

//-----------------END TEST

endmodule