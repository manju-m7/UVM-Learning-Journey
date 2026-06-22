// Environment class derived from uvm_env
class my_env extends uvm_env;
  
  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)
  
  // Variable used to store packet count
  int packet_count;
  
  // Variable used to store final pass/fail status
  bit test_passed;
  
  // Constructor
  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Run phase is a task phase where simulation time can advance
  task run_phase(uvm_phase phase);

    // Raise objection to keep simulation alive
    phase.raise_objection(this);

    // Display run phase execution
    $display("Inside run_phase");

    // Assign packet count value
    packet_count = 10;

    // Delay for 10 time units
    #10;

    // Drop objection to indicate completion of runtime activity
    phase.drop_objection(this);

  endtask
  
  // Extract phase executes after run phase completes
  // Used to collect simulation results
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);

    // Display extract phase execution
    $display("Inside extract_phase");
  endfunction
  
  // Check phase executes after extract phase
  // Used to verify collected results
  function void check_phase(uvm_phase phase);
    super.check_phase(phase);

    // Display check phase execution
    $display("Inside check_phase");

    // Determine pass/fail status
    if(packet_count == 10)
      test_passed = 1;
    else
      test_passed = 0;

  endfunction
  
  // Report phase executes after check phase
  // Used to display final simulation summary
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    // Display report phase execution
    $display("Inside report_phase");

    // Display final test result
    if(test_passed)
      $display("FINAL RESULT : TEST PASSED");
    else
      $display("FINAL RESULT : TEST FAILED");

  endfunction

endclass


// User-defined test class derived from uvm_test
class my_test extends uvm_test;
  
  // Register the test with the UVM factory
  `uvm_component_utils(my_test)
  
  // Handle for environment
  my_env env;
  
  // Constructor
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment as a child of the test
    env = my_env::type_id::create("env", this);
  endfunction
  
endclass

module tb;
  
  initial begin

    // Start the UVM test
    run_test("my_test");

  end
  
endmodule