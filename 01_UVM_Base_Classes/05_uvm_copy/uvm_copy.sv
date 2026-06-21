// Packet class derived from uvm_object
class packet extends uvm_object;

  // 8-bit address field
  rand bit [7:0] addr;

  // Begin field automation registration
  `uvm_object_utils_begin(packet)

    // Register addr field for automatic
    // copy, compare, print, pack and unpack operations
    `uvm_field_int(addr, UVM_ALL_ON)

  // End field automation registration
  `uvm_object_utils_end

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

    // Create packet objects using the UVM factory
    pkt1 = packet::type_id::create("pkt1");
    pkt2 = packet::type_id::create("pkt2");

    // Assign a value to pkt1
    pkt1.addr = 15;

    // Display values before copy operation
    $display("Before Copy");
    $display("pkt1.addr = %0d", pkt1.addr);
    $display("pkt2.addr = %0d", pkt2.addr);

    // Copy registered fields from pkt1 to pkt2
    pkt2.copy(pkt1);

    // Display values after copy operation
    $display("\nAfter Copy");
    $display("pkt1.addr = %0d", pkt1.addr);
    $display("pkt2.addr = %0d", pkt2.addr);

  end

endmodule