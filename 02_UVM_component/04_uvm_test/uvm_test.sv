// User-defined test class derived from uvm_test
class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Constructor
  function new(
    string name = "my_test",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

endclass

module tb;

  initial begin

    // Display a message indicating the start of simulation
    $display("Starting UVM Test");

    // Start the UVM test named "my_test"
    // UVM creates the test using the factory and
    // begins executing the UVM phase mechanism
    run_test("my_test");

  end

endmodule

