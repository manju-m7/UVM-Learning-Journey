// Import all UVM package contents
import uvm_pkg::*;

// Packet class derived from uvm_object
class packet extends uvm_object;

  // Randomizable 8-bit address field
  rand bit [7:0] addr;

  // Constraint: address must be between 10 and 20
  constraint c_addr {
    addr inside {[10:20]};
  }

  // Register the class with the UVM factory
  `uvm_object_utils(packet)

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass

module tb;

  // Handle for packet object
  packet pkt;

  initial begin

    // Create packet object using the UVM factory
    pkt = packet::type_id::create("pkt");

    // Randomize and display the address 5 times
    repeat(5) begin
      pkt.randomize();
      $display("addr = %0d", pkt.addr);
    end

  end

endmodule