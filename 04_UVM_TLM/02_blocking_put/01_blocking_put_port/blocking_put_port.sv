class producer extends uvm_component;

  `uvm_component_utils(producer)

  uvm_blocking_put_port #(int) put_port;

  function new(
    string name = "producer",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    put_port = new("put_port", this);
  endfunction

endclass


class my_test extends uvm_test;

  `uvm_component_utils(my_test)

  producer prod;

  function new(
    string name = "my_test",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    prod = producer::type_id::create("prod", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass


module tb;

  initial begin
    run_test("my_test");
  end

endmodule