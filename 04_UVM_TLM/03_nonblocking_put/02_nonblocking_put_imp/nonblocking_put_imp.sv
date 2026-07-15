class consumer extends uvm_component;

  // Register the consumer with the UVM factory
  `uvm_component_utils(consumer)

  // Nonblocking put implementation used to receive integer transactions
  uvm_nonblocking_put_imp #(int, consumer) put_imp;

  // Constructor
  function new(string name = "consumer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the nonblocking put implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the nonblocking put implementation
    put_imp = new("put_imp", this);

  endfunction

  // Indicates that the consumer is ready to receive data
  function bit can_put();
    return 1;
  endfunction

  // Attempts to receive data
  function bit try_put(int data);

    $display("Received Data = %0d", data);

    return 1;

  endfunction

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