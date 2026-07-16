class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  rand bit [7:0] addr;
  rand bit [7:0] data;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_sequence extends uvm_sequence #(packet);

  // Register the sequence with the UVM factory
  `uvm_object_utils(my_sequence)

  packet pkt;

  // Constructor
  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  // Generate one transaction
  task body();

    pkt = packet::type_id::create("pkt");

    // Inform the sequencer that a new transaction is starting
    start_item(pkt);

    // Fill the transaction fields
    pkt.addr = 8'h10;
    pkt.data = 8'hAA;

    // Inform the sequencer that the transaction is ready
    finish_item(pkt);

  endtask

endclass


class my_sequencer extends uvm_sequencer #(packet);

  // Register the sequencer
  `uvm_component_utils(my_sequencer)

  function new(string name="my_sequencer",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

endclass


class my_driver extends uvm_driver #(packet);

  // Register the driver
  `uvm_component_utils(my_driver)

  function new(string name="my_driver",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);

    packet req;

    forever begin

      // Request the next transaction
      seq_item_port.get_next_item(req);

      $display("---------------------------");
      $display("Driver received transaction");
      $display("Address = %0h", req.addr);
      $display("Data    = %0h", req.data);
      $display("---------------------------");

      // Notify the sequencer that processing is complete
      seq_item_port.item_done();

    end

  endtask

endclass


class my_agent extends uvm_agent;

  // Register the agent
  `uvm_component_utils(my_agent)

  my_driver drv;
  my_sequencer seqr;

  function new(string name="my_agent",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    drv  = my_driver::type_id::create("drv", this);
    seqr = my_sequencer::type_id::create("seqr", this);

  endfunction

  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    drv.seq_item_port.connect(seqr.seq_item_export);

  endfunction

endclass


class my_env extends uvm_env;

  `uvm_component_utils(my_env)

  my_agent agent;

  function new(string name="my_env",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    agent = my_agent::type_id::create("agent", this);

  endfunction

endclass


class my_test extends uvm_test;

  `uvm_component_utils(my_test)

  my_env env;
  my_sequence seq;

  function new(string name="my_test",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    env = my_env::type_id::create("env", this);

  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    seq = my_sequence::type_id::create("seq");

    // Start the sequence on the agent's sequencer
    seq.start(env.agent.seqr);

    phase.drop_objection(this);

  endtask

endclass


module tb;

  initial begin
    run_test("my_test");
  end

endmodule