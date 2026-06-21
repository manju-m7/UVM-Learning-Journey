// Packet class derived from uvm_object
class packet extends uvm_object;

  // Randomizable 8-bit address field
  rand bit [7:0] addr;

  // Constraint: generated address must be between 10 and 20
  constraint c_addr {
    addr inside {[10:20]};
  }

  // Register packet class with the UVM Factory
  // Enables factory-based creation using type_id::create()
  `uvm_object_utils(packet)

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


module tb;

  // Handles for packet objects
  packet pkt1;
  packet pkt2;

  initial begin

    // Create packet objects using the UVM Factory
    pkt1 = packet::type_id::create("pkt1");
    pkt2 = packet::type_id::create("pkt2");

    // Randomize and display values 5 times
    repeat(5) begin

      // Randomize pkt1 and display its name and address
      pkt1.randomize();
      $display("[%s] addr = %0d",
               pkt1.get_name(),
               pkt1.addr);

      // Randomize pkt2 and display its name and address
      pkt2.randomize();
      $display("[%s] addr = %0d",
               pkt2.get_name(),
               pkt2.addr);

    end

  end

endmodule