// Child component derived from uvm_component
class child_component extends uvm_component;

  // Register child_component with the UVM factory
  `uvm_component_utils(child_component)

  // Constructor
  function new(
    string name = "child_component",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

endclass


// Parent component derived from uvm_component
class parent_component extends uvm_component;

  // Register parent_component with the UVM factory
  `uvm_component_utils(parent_component)

  // Handle for child component
  child_component child;

  // Constructor
  function new(
    string name = "parent_component",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  // build_phase is used to construct child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create child component and assign this component
    // as its parent
    child = child_component::type_id::create("child", this);
  endfunction

endclass


// Test class derived from uvm_test
class hierarchy_test extends uvm_test;

  // Register hierarchy_test with the UVM factory
  `uvm_component_utils(hierarchy_test)

  // Handle for parent component
  parent_component parent_comp;

  // Constructor
  function new(
    string name = "hierarchy_test",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  // Create parent component during build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create parent component and assign this test
    // as its parent
    parent_comp = parent_component::type_id::create("parent_comp", this);
  endfunction

  // Print the complete UVM hierarchy
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass

module tb;

  initial begin
    // Start the UVM test
    run_test("hierarchy_test");
  end

endmodule