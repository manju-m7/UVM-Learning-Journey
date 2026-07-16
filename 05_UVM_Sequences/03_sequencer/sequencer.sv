class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  rand bit [7:0] addr;
  rand bit [7:0] data;
  rand bit write;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_sequencer extends uvm_sequencer #(packet);

  // Register the sequencer with the UVM factory
  `uvm_component_utils(my_sequencer)

  // Constructor
  function new(string name = "my_sequencer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for the sequencer
  my_sequencer seqr;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the sequencer
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    seqr = my_sequencer::type_id::create("seqr", this);

  endfunction

  // Print the UVM hierarchy
  function void end_of_elaboration_phase(uvm_phase phase);

    uvm_top.print_topology();

  endfunction

endclass


module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule