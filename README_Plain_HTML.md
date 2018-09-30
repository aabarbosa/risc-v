<h1 id="project">Project</h1>
<p>Simple and functional implementation of the general porpose processing unit risc-v (reduced ISA processor).</p>
<p><em>This project is for learning purposes only.</em></p>
<h2 id="the-set-of-instruction-already-implemented">The set of instruction already implemented</h2>
<p>(opcode ==  5’b00000)   //LW<br>
(opcode ==  5’b01000)  //SW<br>
(opcode ==  5’b11000  &amp;&amp; func3 ==  3’b000)   <strong>BEQ</strong><br>
else  if (opcode ==  5’b11000  &amp;&amp; func3 ==  3’b001)   <strong>BNE</strong><br>
else  if (opcode ==  5’b01100  &amp;&amp; func3 ==  3’b100)   <strong>XOR</strong><br>
else  if (opcode ==  5’b00100  &amp;&amp; func3 ==  3’b100)   <strong>XORI</strong><br>
else  if (opcode ==  5’b00100  &amp;&amp; func3 ==  3’b110)   <strong>ORI</strong><br>
else  if (opcode ==  5’b00100  &amp;&amp; func3 ==  3’b111)   <strong>ANDI</strong><br>
else  if (opcode ==  5’b01100  &amp;&amp; func3 ==  3’b101)   <strong>SRL</strong><br>
begin  //<strong>ADD</strong><br>
7’b0100000) begin  //<strong>SUB</strong><br>
else  if (opcode ==  5’b11011) begin  //<strong>JAL</strong><br>
else  begin  // <strong>ADDI</strong></p>
<h2 id="examples">Examples</h2>
<p>I’ve been already tested.</p>
<pre class=" language-nasm"><code class="prism  language-nasm">.section .text
.globl _start
<span class="token label function">_start:</span>
	addi a1, zero, <span class="token number">0x20</span>
	addi a2, zero, <span class="token number">0x20</span>
	sw a1, <span class="token number">0xfc</span>(zero)
	lw t3, <span class="token number">0xfc</span>(zero)
<span class="token label function">done:</span>
	sub a2 , a2, a2
	sw a2 , <span class="token number">0x34</span>(zero)
	lw s11, <span class="token number">0x34</span>(zero)
	lw t6 , <span class="token number">0x34</span>(zero)
	addi a1 , a1, <span class="token number">1</span>
<span class="token label function">target:</span>
	beq a1, a2, done
	addi t6, a1, <span class="token number">0x99</span>
	jal done
<span class="token label function">end:</span>
</code></pre>
<p>You can also run on FPGA or by hand with systemverilog compiler and test it from terminal running this example like or bypassing any device and putting data on memory following these rules:</p>
<pre class=" language-verilog"><code class="prism  language-verilog"><span class="token keyword">initial</span> <span class="token keyword">begin</span>
	cpu<span class="token punctuation">.</span>processador<span class="token punctuation">.</span>controller<span class="token punctuation">.</span>inst
			<span class="token punctuation">.</span>mem<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">32'hdeadbeef</span><span class="token punctuation">;</span> <span class="token comment">//JAL 7a</span>
	cpu<span class="token punctuation">.</span>processador<span class="token punctuation">.</span>controller<span class="token punctuation">.</span>inst 
			<span class="token punctuation">.</span>mem<span class="token punctuation">[</span><span class="token number">32'h7a</span><span class="token punctuation">]</span><span class="token operator">=</span> <span class="token operator">{</span><span class="token number">12'd252</span><span class="token punctuation">,</span> <span class="token number">5'd00</span><span class="token punctuation">,</span> <span class="token number">3'b010</span><span class="token punctuation">,</span> <span class="token number">5'd24</span><span class="token punctuation">,</span> <span class="token number">7'b0000011</span> <span class="token operator">}</span><span class="token punctuation">;</span> <span class="token comment">//LW from 252, x24</span>
	cpu<span class="token punctuation">.</span>processador<span class="token punctuation">.</span>controller<span class="token punctuation">.</span>inst
			<span class="token punctuation">.</span>mem<span class="token punctuation">[</span><span class="token number">32'h7b</span><span class="token punctuation">]</span><span class="token operator">=</span> <span class="token operator">{</span><span class="token number">12'h0aa</span><span class="token punctuation">,</span> <span class="token number">5'd24</span><span class="token punctuation">,</span> <span class="token number">3'b111</span><span class="token punctuation">,</span> <span class="token number">5'd29</span><span class="token punctuation">,</span> <span class="token number">7'b0010011</span> <span class="token operator">}</span><span class="token punctuation">;</span> <span class="token comment">//ANDI from aa x24, write on x29.</span>
<span class="token keyword">end</span>

</code></pre>
<h2 id="important">Important</h2>
<blockquote>
<p>README</p>
</blockquote>
<p>Take a look on the proprietary software files. But the source code and full implementation you can find in the /src folder.</p>
<p>Please remind that FPGA compatibility interface in /src/DE_0_NANO isn’t by own right. Although other information you can freely copy, and use by your own interest and goal.</p>

