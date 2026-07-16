class producer extends uvm_component;

  // Register the producer with the UVM factory
  `uvm_component_utils(producer)

  // Analysis port used to broadcast integer transactions
  uvm_analysis_port #(int) ap;

  // Constructor
  function new(string name = "producer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the analysis port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the analysis port
    ap = new("ap", this);

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for producer
  producer prod;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the producer
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    prod = producer::type_id::create("prod", this);

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