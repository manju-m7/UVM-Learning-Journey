class subscriber extends uvm_component;

  // Register the subscriber with the UVM factory
  `uvm_component_utils(subscriber)

  // Analysis implementation used to receive integer transactions
  uvm_analysis_imp #(int, subscriber) analysis_imp;

  // Constructor
  function new(string name = "subscriber",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the analysis implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the analysis implementation
    analysis_imp = new("analysis_imp", this);

  endfunction

  // Function automatically called when a transaction is received
  function void write(int data);

    $display("Received Data = %0d", data);

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for subscriber
  subscriber sub;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the subscriber
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    sub = subscriber::type_id::create("sub", this);

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