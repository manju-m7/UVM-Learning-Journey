class packet extends uvm_sequence_item;

  // Register packet with the UVM factory
  `uvm_object_utils(packet)

  rand bit [7:0] addr;
  rand bit [7:0] data;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_sequence extends uvm_sequence #(packet);

  // Register sequence with the UVM factory
  `uvm_object_utils(my_sequence)

  packet pkt;

  // Constructor
  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  // Automatically executed when start() is called
  task body();

    pkt = packet::type_id::create("pkt");

    pkt.addr = 8'h10;
    pkt.data = 8'hAA;

    $display("Sequence Started");
    $display("Address = %0h", pkt.addr);
    $display("Data    = %0h", pkt.data);

  endtask

endclass


class my_sequencer extends uvm_sequencer #(packet);

  // Register sequencer with the UVM factory
  `uvm_component_utils(my_sequencer)

  // Constructor
  function new(string name = "my_sequencer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass


class my_test extends uvm_test;

  // Register test with the UVM factory
  `uvm_component_utils(my_test)

  my_sequence seq;
  my_sequencer seqr;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    seq  = my_sequence::type_id::create("seq");
    seqr = my_sequencer::type_id::create("seqr", this);

  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    // Start the sequence on the sequencer
    seq.start(seqr);

    phase.drop_objection(this);

  endtask

endclass


module tb;

  initial begin
    run_test("my_test");
  end

endmodule