class consumer extends uvm_component;

  // Register the consumer with the UVM factory
  `uvm_component_utils(consumer)

  // Blocking put implementation used to receive integer transactions
  uvm_blocking_put_imp #(int, consumer) put_imp;

  // Constructor
  function new(string name = "consumer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the blocking put implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the blocking put implementation
    put_imp = new("put_imp", this);

  endfunction

  // Task automatically called when data is received
  task put(int data);

    $display("Received Data = %0d", data);

  endtask

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for consumer
  consumer cons;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the consumer
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    cons = consumer::type_id::create(
             "cons",
             this);

  endfunction

  // Print the UVM hierarchy
  function void end_of_elaboration_phase(
                    uvm_phase phase);

    uvm_top.print_topology();

  endfunction

endclass


module tb;

  initial begin
    run_test("my_test");
  end

endmodule