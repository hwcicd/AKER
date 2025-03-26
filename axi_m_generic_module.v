module axi_m_generic_module(
        r_misb_clk_cnt_out,
        r_ready_to_sample_out,
        clk,
        r_start,
        w_start,
        reset,
        axi_resetn,
        r_displ,
        w_displ,
        r_max_outs,
        w_max_outs,
        r_phase,
        w_phase,
        r_base_addr,
        w_base_addr,
        r_num_trans,
        w_num_trans,
        r_burst_len,
        w_burst_len,
        data_val,
        r_misb_clk_cycle,
        w_misb_clk_cycle,
        w_done,
        r_done,
        m_axi_awid,
        m_axi_awaddr,
        m_axi_awlen,
        m_axi_awsize,
        m_axi_awburst,
        m_axi_awlock,
        m_axi_awcache,
        m_axi_awprot,
        m_axi_awqos,
        m_axi_awuser,
        m_axi_awvalid,
        m_axi_awready,
        m_axi_wdata,
        m_axi_wstrb,
        m_axi_wlast,
        m_axi_wuser,
        m_axi_wvalid,
        m_axi_wready,
        m_axi_bid,
        m_axi_bresp,
        m_axi_buser,
        m_axi_bvalid,
        m_axi_bready,
        m_axi_arid,
        m_axi_araddr,
        m_axi_arlen,
        m_axi_arsize,
        m_axi_arburst,
        m_axi_arlock,
        m_axi_arcache,
        m_axi_arprot,
        m_axi_arqos,
        m_axi_aruser,
        m_axi_arvalid,
        m_axi_arready,
        m_axi_rid,
        m_axi_rdata,
        m_axi_rresp,
        m_axi_rlast,
        m_axi_ruser,
        m_axi_rvalid,
        m_axi_rready
    );
    parameter c_m00_axi_target_slave_base_addr  = 8'b00000000;
    parameter [31:0]c_m00_axi_burst_len  = 16;
    parameter [31:0]c_m00_axi_id_width  = 1;
    parameter [31:0]c_m00_axi_addr_width  = 32;
    parameter [31:0]c_m00_axi_data_width  = 32;
    parameter [31:0]c_m00_axi_awuser_width  = 1;
    parameter [31:0]c_m00_axi_aruser_width  = 1;
    parameter [31:0]c_m00_axi_wuser_width  = 1;
    parameter [31:0]c_m00_axi_ruser_width  = 1;
    parameter [31:0]c_m00_axi_buser_width  = 1;
    parameter [31:0]c_s00_axi_id_width  = 1;
    parameter [31:0]c_s00_axi_data_width  = 32;
    parameter [31:0]c_s00_axi_addr_width  = 32;
    parameter [31:0]c_s00_axi_awuser_width  = 1;
    parameter [31:0]c_s00_axi_aruser_width  = 1;
    parameter [31:0]c_s00_axi_wuser_width  = 1;
    parameter [31:0]c_s00_axi_ruser_width  = 1;
    parameter [31:0]c_s00_axi_buser_width  = 1;
    output [15:0]r_misb_clk_cnt_out;
    output r_ready_to_sample_out;
    input clk;
    input r_start;
    input w_start;
    input reset;
    input axi_resetn;
    input [7:0]r_displ;
    input [7:0]w_displ;
    input [7:0]r_max_outs;
    input [7:0]w_max_outs;
    input [15:0]r_phase;
    input [15:0]w_phase;
    input [31:0]r_base_addr;
    input [31:0]w_base_addr;
    input [15:0]r_num_trans;
    input [15:0]w_num_trans;
    input [7:0]r_burst_len;
    input [7:0]w_burst_len;
    input data_val;
    input [15:0]r_misb_clk_cycle;
    input [15:0]w_misb_clk_cycle;
    output w_done;
    output r_done;
    output [( c_m00_axi_id_width - 1 ):0]m_axi_awid;
    output [( c_s00_axi_addr_width - 1 ):0]m_axi_awaddr;
    output [7:0]m_axi_awlen;
    output [2:0]m_axi_awsize;
    output [1:0]m_axi_awburst;
    output m_axi_awlock;
    output [3:0]m_axi_awcache;
    output [2:0]m_axi_awprot;
    output [3:0]m_axi_awqos;
    output [( c_m00_axi_awuser_width - 1 ):0]m_axi_awuser;
    output m_axi_awvalid;
    input m_axi_awready;
    output [( c_m00_axi_data_width - 1 ):0]m_axi_wdata;
    output [( ( c_m00_axi_data_width / 8 ) - 1 ):0]m_axi_wstrb;
    output m_axi_wlast;
    output [( c_m00_axi_wuser_width - 1 ):0]m_axi_wuser;
    output m_axi_wvalid;
    input m_axi_wready;
    input [( c_m00_axi_id_width - 1 ):0]m_axi_bid;
    input [1:0]m_axi_bresp;
    input [( c_m00_axi_buser_width - 1 ):0]m_axi_buser;
    input m_axi_bvalid;
    output m_axi_bready;
    output [( c_m00_axi_id_width - 1 ):0]m_axi_arid;
    output [( c_m00_axi_addr_width - 1 ):0]m_axi_araddr;
    output [7:0]m_axi_arlen;
    output [2:0]m_axi_arsize;
    output [1:0]m_axi_arburst;
    output m_axi_arlock;
    output [3:0]m_axi_arcache;
    output [2:0]m_axi_arprot;
    output [3:0]m_axi_arqos;
    output [( c_m00_axi_aruser_width - 1 ):0]m_axi_aruser;
    output m_axi_arvalid;
    input m_axi_arready;
    input [( c_m00_axi_id_width - 1 ):0]m_axi_rid;
    input [( c_m00_axi_data_width - 1 ):0]m_axi_rdata;
    input [1:0]m_axi_rresp;
    input m_axi_rlast;
    input [( c_m00_axi_ruser_width - 1 ):0]m_axi_ruser;
    input m_axi_rvalid;
    output m_axi_rready;
    wire [15:0]w_misb_clk_cnt;
    wire r_ready_to_sample;
    reg [7:0]r_displ_int;
    reg [7:0]w_displ_int;
    reg [7:0]r_max_outs_int;
    reg [7:0]w_max_outs_int;
    reg [15:0]r_phase_int;
    reg [15:0]w_phase_int;
    reg [31:0]r_base_addr_int;
    reg [31:0]w_base_addr_int;
    reg [15:0]r_num_trans_int;
    reg [15:0]w_num_trans_int;
    reg [7:0]r_burst_len_int;
    reg [7:0]w_burst_len_int;
    reg data_val_flag;
    reg r_phase_start;
    reg w_phase_start;
    reg [15:0]r_phase_counter;
    reg [15:0]w_phase_counter;
    reg w_start_int;
    reg r_start_int;
    reg r_done;
    reg w_done;
    reg [15:0]r_trans_counter;
    reg [15:0]r_displ_cnt;
    reg [15:0]r_pend_outs_trans;
    reg [0:0]r_grant_trans_flag;
    reg r_addr_init;
    reg [( c_m00_axi_addr_width - 1 ):0]m_axi_araddr_int;
    reg m_axi_arvalid_int;
    reg [2:0]r_state;
    reg [15:0]w_trans_counter;
    reg [15:0]w_displ_cnt;
    reg [0:0]w_grant_trans_flag;
    reg w_addr_init;
    reg [15:0]w_pend_outs_trans;
    reg [( c_m00_axi_addr_width - 1 ):0]m_axi_awaddr_int;
    reg m_axi_awvalid_int;
    reg [2:0]w_state;
    reg [15:0]r_done_counter;
    reg [15:0]r_misb_clk_cnt;
    reg [0:0]r_end_trans_flag;
    reg [15:0]w_data_done_cnt;
    reg [7:0]w_data_counter;
    reg [31:0]m_axi_wdata_int;
    reg m_axi_wvalid_int;
    reg m_axi_wlast_int;
    reg [15:0]w_done_counter;
    reg [0:0]w_end_trans_flag;
    assign r_misb_clk_cnt_out = r_misb_clk_cnt;
    assign r_ready_to_sample_out = r_ready_to_sample;
    assign m_axi_awid = 1'b0;
    assign m_axi_awaddr = m_axi_awaddr_int;
    assign m_axi_awlen = w_burst_len_int;
    assign m_axi_awsize = 3'b010;
    assign m_axi_awburst = 2'b01;
    assign m_axi_awlock = 1'b0;
    assign m_axi_awcache = 4'b0011;
    assign m_axi_awprot = 3'b000;
    assign m_axi_awqos = 1'b0;
    assign m_axi_awuser = 1'b0;
    assign m_axi_awvalid = m_axi_awvalid_int;
    assign m_axi_wdata = m_axi_wdata_int;
    assign m_axi_wstrb = 4'b1111;
    assign m_axi_wlast = m_axi_wlast_int;
    assign m_axi_wuser = 1'b0;
    assign m_axi_wvalid = m_axi_wvalid_int;
    assign m_axi_bready = 1'b1;
    assign m_axi_arid = 1'b0;
    assign m_axi_araddr = m_axi_araddr_int;
    assign m_axi_arlen = r_burst_len_int;
    assign m_axi_arsize = 3'b010;
    assign m_axi_arburst = 2'b01;
    assign m_axi_arlock = 1'b0;
    assign m_axi_arcache = 4'b0011;
    assign m_axi_arprot = 3'b000;
    assign m_axi_arqos = 1'b0;
    assign m_axi_aruser = 1'b0;
    assign m_axi_arvalid = m_axi_arvalid_int;
    always @ (  posedge clk)
    begin : data_set_process
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            r_displ_int <= { 1'b0 };
            w_displ_int <= { 1'b0 };
            r_max_outs_int <= { 1'b0 };
            w_max_outs_int <= { 1'b0 };
            r_phase_int <= { 1'b0 };
            w_phase_int <= { 1'b0 };
            r_base_addr_int <= { 1'b0 };
            w_base_addr_int <= { 1'b0 };
            r_num_trans_int <= { 1'b0 };
            w_num_trans_int <= { 1'b0 };
            r_burst_len_int <= { 1'b0 };
            w_burst_len_int <= { 1'b0 };
            data_val_flag <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( data_val == 1'b1 ) 
                begin
                    r_displ_int <= r_displ;
                    w_displ_int <= w_displ;
                    r_max_outs_int <= r_max_outs;
                    w_max_outs_int <= w_max_outs;
                    r_phase_int <= r_phase;
                    w_phase_int <= w_phase;
                    r_base_addr_int <= r_base_addr;
                    w_base_addr_int <= w_base_addr;
                    r_num_trans_int <= r_num_trans;
                    w_num_trans_int <= w_num_trans;
                    data_val_flag <= 1'b1;
                    r_burst_len_int <= r_burst_len;
                    w_burst_len_int <= w_burst_len;
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : start_proc
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            r_phase_start <= 1'b0;
            w_phase_start <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( r_start == 1'b1 ) 
                begin
                    r_phase_start <= 1'b1;
                end
                if ( w_start == 1'b1 ) 
                begin
                    w_phase_start <= 1'b1;
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : phase_proc
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            r_phase_counter <= { 1'b0 };
            w_phase_counter <= { 1'b0 };
            w_start_int <= 1'b0;
            r_start_int <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( r_phase_start == 1'b1 ) 
                begin
                    if ( r_phase_counter != r_phase_int ) 
                    begin
                        r_phase_counter <= ( r_phase_counter + 1 );
                    end
                    else
                    begin 
                        r_start_int <= 1'b1;
                    end
                end
                if ( w_phase_start == 1'b1 ) 
                begin
                    if ( w_phase_counter != w_phase_int ) 
                    begin
                        w_phase_counter <= ( w_phase_counter + 1 );
                    end
                    else
                    begin 
                        w_start_int <= 1'b1;
                    end
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : done_proc
        if ( clk == 1'b1 ) 
        begin
            if ( data_val_flag == 1'b1 ) 
            begin
                if ( r_done_counter == r_num_trans_int ) 
                begin
                    r_done <= 1'b1;
                end
                if ( w_done_counter == w_num_trans_int ) 
                begin
                    w_done <= 1'b1;
                end
            end
            else
            begin 
                r_done <= 1'b0;
                w_done <= 1'b0;
            end
        end
    end
    always @ (  posedge clk)
    begin : address_read_channel_process
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            r_trans_counter <= { 1'b0 };
            r_displ_cnt <= { 1'b0 };
            r_pend_outs_trans <= { 1'b0 };
            r_grant_trans_flag <= 1'b0;
            r_addr_init <= 1'b0;
            r_state <= 3'b000;
            m_axi_araddr_int <= r_base_addr_int;
            m_axi_arvalid_int <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                r_grant_trans_flag <= 1'b0;
                r_pend_outs_trans <= ( r_pend_outs_trans - r_end_trans_flag );
                if ( r_start_int == 1'b1 ) 
                begin
                    if ( r_state == 3'b000 ) 
                    begin
                        if ( ( r_trans_counter < r_num_trans_int ) & ( r_pend_outs_trans < r_max_outs_int ) ) 
                        begin
                            if ( r_addr_init == 1'b0 ) 
                            begin
                                m_axi_araddr_int <= r_base_addr_int;
                                r_addr_init <= 1'b1;
                            end
                            else
                            begin 
                                m_axi_araddr_int <= ( m_axi_araddr_int + { ( r_burst_len_int[5:0] + 1'b1 ), 2'b00 } );
                            end
                            m_axi_arvalid_int <= 1'b1;
                            r_state <= 3'b001;
                            r_trans_counter <= ( r_trans_counter + 1 );
                            r_grant_trans_flag <= 1'b1;
                        end
                        else
                        begin 
                            m_axi_arvalid_int <= 1'b0;
                        end
                    end
                    else
                    begin 
                        if ( r_state == 3'b001 ) 
                        begin
                            if ( ( m_axi_arvalid_int == 1'b1 ) & ( m_axi_arready == 1'b1 ) ) 
                            begin
                                if ( r_displ_cnt < r_displ_int ) 
                                begin
                                    r_displ_cnt <= ( r_displ_cnt + 1 );
                                    r_state <= 3'b010;
                                end
                                else
                                begin 
                                    r_state <= 3'b000;
                                end
                                m_axi_arvalid_int <= 1'b0;
                            end
                        end
                        else
                        begin 
                            if ( r_state == 3'b010 ) 
                            begin
                                if ( r_displ_cnt == r_displ_int ) 
                                begin
                                    r_displ_cnt <= { 1'b0 };
                                    r_state <= 3'b000;
                                end
                                else
                                begin 
                                    r_displ_cnt <= ( r_displ_cnt + 1 );
                                end
                            end
                            else
                            begin 
                                m_axi_arvalid_int <= 1'b0;
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : address_write_channel_process
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            w_trans_counter <= { 1'b0 };
            w_displ_cnt <= { 1'b0 };
            w_grant_trans_flag <= 1'b0;
            w_addr_init <= 1'b0;
            w_state <= 3'b000;
            w_pend_outs_trans <= 0;
            m_axi_awaddr_int <= w_base_addr_int;
            m_axi_awvalid_int <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                w_grant_trans_flag <= 1'b0;
                w_pend_outs_trans <= w_pend_outs_trans + w_grant_trans_flag - w_end_trans_flag;
                if ( w_start_int == 1'b1 ) 
                begin
                    if ( w_state == 3'b000 ) 
                    begin
                        if ( ( w_trans_counter < w_num_trans_int ) & ( w_pend_outs_trans < w_max_outs_int ) ) 
                        begin
                            if ( w_addr_init == 1'b0 ) 
                            begin
                                m_axi_awaddr_int <= w_base_addr_int;
                                w_addr_init <= 1'b1;
                            end
                            else
                            begin 
                                m_axi_awaddr_int <= ( m_axi_awaddr_int + { ( w_burst_len_int[5:0] + 1'b1 ), 2'b00 } );
                            end
                            m_axi_awvalid_int <= 1'b1;
                            w_state <= 3'b001;
                            w_grant_trans_flag <= 1'b1;
                        end
                        else
                        begin 
                            m_axi_awvalid_int <= 1'b0;
                        end
                    end
                    else
                    begin 
                        if ( w_state == 3'b001 ) 
                        begin
                            if ( ( m_axi_awvalid_int == 1'b1 ) & ( m_axi_awready == 1'b1 ) ) 
                            begin
                                w_trans_counter <= ( w_trans_counter + 1 );
                                if ( w_displ_cnt < w_displ_int ) 
                                begin
                                    w_displ_cnt <= ( w_displ_cnt + 1 );
                                    w_state <= 3'b010;
                                end
                                else
                                begin 
                                    w_state <= 3'b000;
                                end
                                m_axi_awvalid_int <= 1'b0;
                            end
                        end
                        else
                        begin 
                            if ( w_state == 3'b010 ) 
                            begin
                                if ( w_displ_cnt == w_displ_int ) 
                                begin
                                    w_displ_cnt <= { 1'b0 };
                                    w_state <= 3'b000;
                                end
                                else
                                begin 
                                    w_displ_cnt <= ( w_displ_cnt + 1 );
                                end
                            end
                            else
                            begin 
                                m_axi_awvalid_int <= 1'b0;
                            end
                        end
                    end
                end
            end
        end
    end
    assign r_ready_to_sample = & ( ~( ( r_misb_clk_cnt ^ r_misb_clk_cycle )));
    assign m_axi_rready = r_ready_to_sample;
    always @ (  posedge clk)
    begin : data_read_channel
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            r_done_counter <= { 1'b0 };
            r_misb_clk_cnt <= { 1'b0 };
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( ( ( m_axi_rvalid == 1'b1 ) & ( r_ready_to_sample == 1'b1 ) ) & ( m_axi_rlast == 1'b1 ) ) 
                begin
                    r_done_counter <= ( r_done_counter + 1 );
                    r_end_trans_flag <= 1'b1;
                    r_misb_clk_cnt <= { 1'b0 };
                end
                else
                begin 
                    if ( ( m_axi_rvalid == 1'b1 ) & ( r_ready_to_sample == 1'b0 ) ) 
                    begin
                        r_misb_clk_cnt <= ( r_misb_clk_cnt + 1 );
                    end
                    else
                    begin 
                        r_end_trans_flag <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : data_write_channel
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            w_data_done_cnt <= { 1'b0 };
            w_data_counter <= 2'b01;
            m_axi_wdata_int <= 8'b00000000;
            m_axi_wlast_int <= 1'b0;
            m_axi_wvalid_int <= 1'b0;
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( w_data_done_cnt < w_trans_counter ) 
                begin
                    m_axi_wvalid_int <= 1'b1;
                end
                else
                begin 
                    m_axi_wvalid_int <= 1'b0;
                end
                if ( ( m_axi_wvalid_int == 1'b1 ) & ( m_axi_wready == 1'b1 ) ) 
                begin
                    if ( w_data_counter == w_burst_len_int ) 
                    begin
                        m_axi_wlast_int <= 1'b1;
                        w_data_counter <= 2'b00;
                        w_data_done_cnt <= ( w_data_done_cnt + 1 );
                    end
                    else
                    begin 
                        w_data_counter <= ( w_data_counter + 1 );
                        m_axi_wlast_int <= 1'b0;
                    end
                    m_axi_wdata_int <= { 6'b000000, w_data_counter };
                end
            end
        end
    end
    always @ (  posedge clk)
    begin : b_resp_channel
        if ( ( reset == 1'b1 ) | ( axi_resetn == 1'b0 ) ) 
        begin
            w_done_counter <= { 1'b0 };
        end
        else
        begin 
            if ( clk == 1'b1 ) 
            begin
                if ( m_axi_bvalid == 1'b1 ) 
                begin
                    w_done_counter <= ( w_done_counter + 1 );
                    w_end_trans_flag <= 1'b1;
                end
                else
                begin 
                    w_end_trans_flag <= 1'b0;
                end
            end
        end
    end
endmodule