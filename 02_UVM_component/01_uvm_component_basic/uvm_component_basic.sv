// Simple component derived from uvm_component
class my_component extends uvm_component;

  // Register the component with the UVM factory
  `uvm_component_utils(my_component)

  // Constructor
  // Every uvm_component constructor requires:
  // 1. Component name
  // 2. Parent component handle
  function new(
    string name = "my_component",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

endclass


module tb;

  // Handle for the component
  my_component comp;

  initial begin

    // Create the component using the UVM factory
    // Since this is a top-level component, parent is null
    comp = my_component::type_id::create("comp", null);

    // Display the component name
    $display("Component Name = %s", comp.get_name());

  end

endmodule
```
