// Import all UVM package contents
import uvm_pkg::*;

// Packet class derived from uvm_object
// uvm_object is the base class for all UVM data objects
class packet extends uvm_object;

  // Randomizable 8-bit address field
  rand bit [7:0] addr;

  // Register packet class with the UVM factory
  // Enables type_id::create() and factory overrides
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

    // Randomize all rand variables
    pkt.randomize();

    // Display randomized address
    $display("addr = %0d", pkt.addr);

  end

endmodule