-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity AESL_autobram_x is
    generic (
        constant    TV_IN       :   STRING (1 to 44) := "../tv/cdatafile/c.feedforward.autotvin_x.dat";
        constant    TV_OUT      :   STRING (1 to 49) := "../tv/rtldatafile/rtl.feedforward.autotvout_x.dat";
        constant    DATA_WIDTH  :   INTEGER := 32;
        constant    ADDR_WIDTH  :   integer := 32;
        constant    DEPTH       :   integer := 178
    );
    port (
        Clk_A       :   IN  STD_LOGIC;
        Rst_A       :   IN  STD_LOGIC;
        EN_A        :   IN  STD_LOGIC;
        WEN_A       :   IN  STD_LOGIC_VECTOR (DATA_WIDTH/8 - 1 downto 0);
        Addr_A      :   IN  STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
        Din_A       :   IN  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        Dout_A      :   OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        Clk_B       :   IN  STD_LOGIC;
        Rst_B       :   IN  STD_LOGIC;
        EN_B        :   IN  STD_LOGIC;
        WEN_B       :   IN  STD_LOGIC_VECTOR (DATA_WIDTH/8 - 1 downto 0);
        Addr_B      :   IN  STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
        Din_B       :   IN  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        Dout_B      :   OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        ready       :   IN  STD_LOGIC;
        done        :   IN  STD_LOGIC
    );
end AESL_autobram_x;

architecture behav of AESL_autobram_x is

    -- Inner signals 

	type arr2D is array(0 to DEPTH - 1) of STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	shared variable     mem             :   arr2D := (others => (others => '0'));

      procedure esl_read_token (file textfile: TEXT; textline: inout LINE; token: out STRING; token_len: out INTEGER) is
          variable whitespace : CHARACTER;
          variable i : INTEGER;
          variable ok: BOOLEAN;
          variable buff: STRING(1 to token'length);
      begin
          ok := false;
          i := 1;
          loop_main: while not endfile(textfile) loop
              if textline = null or textline'length = 0 then
                  readline(textfile, textline);
              end if;
              loop_remove_whitespace: while textline'length > 0 loop
                  if textline(textline'left) = ' ' or
                      textline(textline'left) = HT or
                      textline(textline'left) = CR or
                      textline(textline'left) = LF then
                      read(textline, whitespace);
                  else 
                      exit loop_remove_whitespace;
                  end if;
              end loop;
              loop_aesl_read_token: while textline'length > 0 and i <= buff'length loop
                  if textline(textline'left) = ' ' or
                     textline(textline'left) = HT or
                     textline(textline'left) = CR or
                     textline(textline'left) = LF then
                      exit loop_aesl_read_token;
                  else 
                      read(textline, buff(i));
                      i := i + 1;
                  end if;
                  ok := true;
              end loop;
              if ok = true then
                  exit loop_main;
              end if;
          end loop;
          buff(i) := ' ';
          token := buff;
          token_len:= i-1;
      end procedure esl_read_token;

      procedure esl_read_token (file textfile: TEXT; 
                                textline: inout LINE; 
                                token: out STRING) is
          variable i : INTEGER;
      begin
          esl_read_token (textfile, textline, token, i);
      end procedure esl_read_token;

      function esl_str2lv_hex (RHS : STRING; data_width : INTEGER) return STD_LOGIC_VECTOR is
          variable	ret	:   STD_LOGIC_VECTOR(data_width - 1 downto 0);
          variable	idx	:   integer := 3;
      begin
          ret := (others => '0');
          if(RHS(1) /= '0' and (RHS(2) /= 'x' or RHS(2) /= 'X')) then
     	        report "Error! The format of hex number is not initialed by 0x";
          end if;
          while true loop
              if (data_width > 4) then
                  case RHS(idx)  is
                      when '0'    =>  ret := ret(data_width - 5 downto 0) & "0000";
     	                when '1'    =>  ret := ret(data_width - 5 downto 0) & "0001";
                      when '2'    =>  ret := ret(data_width - 5 downto 0) & "0010";
                      when '3'    =>  ret := ret(data_width - 5 downto 0) & "0011";
                      when '4'    =>  ret := ret(data_width - 5 downto 0) & "0100";
                      when '5'    =>  ret := ret(data_width - 5 downto 0) & "0101";
                      when '6'    =>  ret := ret(data_width - 5 downto 0) & "0110";
                      when '7'    =>  ret := ret(data_width - 5 downto 0) & "0111";
                      when '8'    =>  ret := ret(data_width - 5 downto 0) & "1000";
                      when '9'    =>  ret := ret(data_width - 5 downto 0) & "1001";
                      when 'a' | 'A'  =>  ret := ret(data_width - 5 downto 0) & "1010";
                      when 'b' | 'B'  =>  ret := ret(data_width - 5 downto 0) & "1011";
                      when 'c' | 'C'  =>  ret := ret(data_width - 5 downto 0) & "1100";
                      when 'd' | 'D'  =>  ret := ret(data_width - 5 downto 0) & "1101";
                      when 'e' | 'E'  =>  ret := ret(data_width - 5 downto 0) & "1110";
                      when 'f' | 'F'  =>  ret := ret(data_width - 5 downto 0) & "1111";
                      when 'x' | 'X'  =>  ret := ret(data_width - 5 downto 0) & "XXXX";
                      when ' '    =>  return ret;
                      when others    =>  report "Wrong hex char " & RHS(idx);	return ret;
                  end case;
              elsif (data_width = 4) then
                  case RHS(idx)  is
                      when '0'    =>  ret := "0000";
     	                when '1'    =>  ret := "0001";
                      when '2'    =>  ret := "0010";
                      when '3'    =>  ret := "0011";
                      when '4'    =>  ret := "0100";
                      when '5'    =>  ret := "0101";
                      when '6'    =>  ret := "0110";
                      when '7'    =>  ret := "0111";
                      when '8'    =>  ret := "1000";
                      when '9'    =>  ret := "1001";
                      when 'a' | 'A'  =>  ret := "1010";
                      when 'b' | 'B'  =>  ret := "1011";
                      when 'c' | 'C'  =>  ret := "1100";
                      when 'd' | 'D'  =>  ret := "1101";
                      when 'e' | 'E'  =>  ret := "1110";
                      when 'f' | 'F'  =>  ret := "1111";
                      when 'x' | 'X'  =>  ret := "XXXX";
                      when ' '    =>  return ret;
                      when others    =>  report "Wrong hex char " & RHS(idx);	return ret;
                  end case;
              elsif (data_width = 3) then
                  case RHS(idx)  is
                      when '0'    =>  ret := "000";
     	                when '1'    =>  ret := "001";
                      when '2'    =>  ret := "010";
                      when '3'    =>  ret := "011";
                      when '4'    =>  ret := "100";
                      when '5'    =>  ret := "101";
                      when '6'    =>  ret := "110";
                      when '7'    =>  ret := "111";
                      when 'x' | 'X'  =>  ret := "XXX";
                      when ' '    =>  return ret;
                      when others    =>  report "Wrong hex char " & RHS(idx);	return ret;
                  end case;
              elsif (data_width = 2) then
                  case RHS(idx)  is
                      when '0'    =>  ret := "00";
     	                when '1'    =>  ret := "01";
                      when '2'    =>  ret := "10";
                      when '3'    =>  ret := "11";
                      when 'x' | 'X'  =>  ret := "XX";
                      when ' '    =>  return ret;
                      when others    =>  report "Wrong hex char " & RHS(idx);	return ret;
                  end case;
              elsif (data_width = 1) then
                  case RHS(idx)  is
                      when '0'    =>  ret := "0";
     	                when '1'    =>  ret := "1";
                      when 'x' | 'X'  =>  ret := "X";
                      when ' '    =>  return ret;
                      when others    =>  report "Wrong hex char " & RHS(idx);	return ret;
                  end case;
              else
                  report string'("Wrong data_width.");
                  return ret;
              end if;
              idx := idx + 1;
          end loop;
          return ret;
      end function;

      function esl_conv_string_hex (lv : STD_LOGIC_VECTOR) return STRING is
          constant str_len : integer := (lv'length + 3)/4;
          variable ret : STRING (1 to str_len);
          variable i, tmp: INTEGER;
          variable normal_lv : STD_LOGIC_VECTOR(lv'length - 1 downto 0);
          variable tmp_lv : STD_LOGIC_VECTOR(3 downto 0);
      begin
          normal_lv := lv;
          for i in 1 to str_len loop
              if(i = 1) then
                  if((lv'length mod 4) = 3) then
                      tmp_lv(2 downto 0) := normal_lv(lv'length - 1 downto lv'length - 3);
                      case tmp_lv(2 downto 0) is
                          when "000" => ret(i) := '0';
                          when "001" => ret(i) := '1';
                          when "010" => ret(i) := '2';
                          when "011" => ret(i) := '3';
                          when "100" => ret(i) := '4';
                          when "101" => ret(i) := '5';
                          when "110" => ret(i) := '6';
                          when "111" => ret(i) := '7';
                          when others  => ret(i) := 'X';
                      end case;
                  elsif((lv'length mod 4) = 2) then
                      tmp_lv(1 downto 0) := normal_lv(lv'length - 1 downto lv'length - 2);
                      case tmp_lv(1 downto 0) is
                          when "00" => ret(i) := '0';
                          when "01" => ret(i) := '1';
                          when "10" => ret(i) := '2';
                          when "11" => ret(i) := '3';
                          when others => ret(i) := 'X';
                      end case;
                  elsif((lv'length mod 4) = 1) then
                      tmp_lv(0 downto 0) := normal_lv(lv'length - 1 downto lv'length - 1);
                      case tmp_lv(0 downto 0) is
                          when "0" => ret(i) := '0';
                          when "1" => ret(i) := '1';
                          when others=> ret(i) := 'X';
                      end case;
                  elsif((lv'length mod 4) = 0) then
                      tmp_lv(3 downto 0) := normal_lv(lv'length - 1 downto lv'length - 4);
                      case tmp_lv(3 downto 0) is
                          when "0000" => ret(i) := '0';
                          when "0001" => ret(i) := '1';
                          when "0010" => ret(i) := '2';
                          when "0011" => ret(i) := '3';
                          when "0100" => ret(i) := '4';
                          when "0101" => ret(i) := '5';
                          when "0110" => ret(i) := '6';
                          when "0111" => ret(i) := '7';
                          when "1000" => ret(i) := '8';
                          when "1001" => ret(i) := '9';
                          when "1010" => ret(i) := 'a';
                          when "1011" => ret(i) := 'b';
                          when "1100" => ret(i) := 'c';
                          when "1101" => ret(i) := 'd';
                          when "1110" => ret(i) := 'e';
                          when "1111" => ret(i) := 'f';
                          when others   => ret(i) := 'X';
                      end case;
                  end if;
              else
                  tmp_lv(3 downto 0) := normal_lv((str_len - i) * 4 + 3 downto (str_len - i) * 4);
                  case tmp_lv(3 downto 0) is
                      when "0000" => ret(i) := '0';
                      when "0001" => ret(i) := '1';
                      when "0010" => ret(i) := '2';
                      when "0011" => ret(i) := '3';
                      when "0100" => ret(i) := '4';
                      when "0101" => ret(i) := '5';
                      when "0110" => ret(i) := '6';
                      when "0111" => ret(i) := '7';
                      when "1000" => ret(i) := '8';
                      when "1001" => ret(i) := '9';
                      when "1010" => ret(i) := 'a';
                      when "1011" => ret(i) := 'b';
                      when "1100" => ret(i) := 'c';
                      when "1101" => ret(i) := 'd';
                      when "1110" => ret(i) := 'e';
                      when "1111" => ret(i) := 'f';
                      when others   => ret(i) := 'X';
                  end case;
              end if;
          end loop;
          return ret;
      end function;

begin

   ---------------------------Read array-------------------
  -- Read data from file to array
  read_file_proc  :   process
      file        fp          :   TEXT;
      variable    fstatus     :   FILE_OPEN_STATUS;
      variable    token_line  :   LINE;
      variable    token       :   STRING(1 to 1024);
      variable    token_len   :   INTEGER;
	    variable    token_int	:   INTEGER;
      variable    transaction_idx :   INTEGER;
	    variable    idx		    :   INTEGER;
    begin
    wait until Rst_A = '0';
      transaction_idx :=  0;
      file_open(fstatus, fp, TV_IN, READ_MODE);
		if(fstatus /= OPEN_OK) then
          assert false report "Open file " & TV_IN & " failed!!!" severity failure;
		end if;
      esl_read_token(fp, token_line, token);
      if(token(1 to 13) /= "[[[runtime]]]") then
          assert false report "ERROR: Simulation using HLS TB failed." severity failure;
      end if;
      esl_read_token(fp, token_line, token);
      while(token(1 to 14) /= "[[[/runtime]]]") loop
          if(token(1 to 15) /= "[[transaction]]") then
              assert false report "ERROR: Simulation using HLS TB failed." severity failure;
          end if;
          esl_read_token(fp, token_line, token);  -- Skip transaction number
          -- Start to read data for every transaction round
          wait for 0.2 ns;
          while(ready /= '1') loop
              wait until Clk_A'event and Clk_A = '1';
              wait for 0.2 ns;
          end loop;
          for i in 0 to DEPTH - 1 loop
              esl_read_token(fp, token_line, token);
              mem(i) := esl_str2lv_hex(token, DATA_WIDTH);
          end loop;
          esl_read_token(fp, token_line, token);
          if(token(1 to 16) /= "[[/transaction]]") then
              assert false report "ERROR: Simulation using HLS TB failed." severity failure;
          end if;
          esl_read_token(fp, token_line, token);
          transaction_idx := transaction_idx + 1;
          wait until Clk_A'event and Clk_A = '1';
      end loop;
      file_close(fp);
      wait;
    end process;

    -- Read data from array to RTL
    read_proc_A : process(Clk_A, Rst_A)
    begin
        if(Rst_A = '1') then
            Dout_A <= (others => '0');
        elsif (Clk_A'event and Clk_A = '1') then
            if(EN_A = '1' and (CONV_INTEGER(Addr_A)*8/32 < DEPTH)) then
                Dout_A <= mem(CONV_INTEGER(Addr_A)*8/32);
            end if;
        end if;
    end process;
    read_proc_B : process(Clk_B, Rst_B)
    begin
        if(Rst_B = '1') then
            Dout_B <= (others => '0');
        elsif (Clk_B'event and Clk_B = '1') then
            if(EN_B = '1' and (CONV_INTEGER(Addr_B)*8/32 < DEPTH)) then
                Dout_B <= mem(CONV_INTEGER(Addr_B)*8/32);
            end if;
        end if;
    end process;

    ----------------------Write array------------------------

    --Write data from RTL to array
    write_proc_A : process(Clk_A)
    begin
        if (Clk_A'event and Clk_A = '1') then
            if(EN_A = '1') then
                  if(WEN_A(0) = '1') then
                      mem(CONV_INTEGER(Addr_A)*8/DATA_WIDTH)(0*8+7 downto 0*8) := Din_A(0*8+7 downto 0*8);
                  end if;
                  if(WEN_A(1) = '1') then
                      mem(CONV_INTEGER(Addr_A)*8/DATA_WIDTH)(1*8+7 downto 1*8) := Din_A(1*8+7 downto 1*8);
                  end if;
                  if(WEN_A(2) = '1') then
                      mem(CONV_INTEGER(Addr_A)*8/DATA_WIDTH)(2*8+7 downto 2*8) := Din_A(2*8+7 downto 2*8);
                  end if;
                  if(WEN_A(3) = '1') then
                      mem(CONV_INTEGER(Addr_A)*8/DATA_WIDTH)(3*8+7 downto 3*8) := Din_A(3*8+7 downto 3*8);
                  end if;
            end if;
        end if;
    end process;
    write_proc_B : process(Clk_B)
    begin
        if (Clk_B'event and Clk_B = '1') then
            if(EN_B = '1') then
                  if(WEN_B(0) = '1') then
                      mem(CONV_INTEGER(Addr_B)*8/DATA_WIDTH)(0*8+7 downto 0*8) := Din_B(0*8+7 downto 0*8);
                  end if;
                  if(WEN_B(1) = '1') then
                      mem(CONV_INTEGER(Addr_B)*8/DATA_WIDTH)(1*8+7 downto 1*8) := Din_B(1*8+7 downto 1*8);
                  end if;
                  if(WEN_B(2) = '1') then
                      mem(CONV_INTEGER(Addr_B)*8/DATA_WIDTH)(2*8+7 downto 2*8) := Din_B(2*8+7 downto 2*8);
                  end if;
                  if(WEN_B(3) = '1') then
                      mem(CONV_INTEGER(Addr_B)*8/DATA_WIDTH)(3*8+7 downto 3*8) := Din_B(3*8+7 downto 3*8);
                  end if;
            end if;
        end if;
    end process;

    -- Write data from array to file
    write_file_proc :   process
        file        fp              :   TEXT;
        variable    fstatus         :   FILE_OPEN_STATUS;
        variable    token_line      :   LINE;
        variable    token           :   STRING(1 to 128);
        variable    transaction_idx :   INTEGER;
    begin
        wait until (Rst_A = '0');
        transaction_idx :=  0;
        while(true) loop
            wait for 0.1 ns;
            while(done /= '1') loop
                wait until Clk_A'event and Clk_A = '1';
                wait for 0.1 ns;
            end loop;
            file_open(fstatus, fp, TV_OUT, APPEND_MODE);
		    if(fstatus /= OPEN_OK) then
		        assert false report "Open file " & TV_OUT & " failed!!!" severity failure;
            end if;
            write(token_line, "[[transaction]]    " & integer'image(transaction_idx));
            writeline(fp, token_line);
            for i in 0 to DEPTH - 1 loop
		        write(token_line, "0x" & esl_conv_string_hex(mem(i)));
		        writeline(fp, token_line);
            end loop;
            write(token_line, string'("[[/transaction]]"));
            writeline(fp, token_line);
            transaction_idx := transaction_idx + 1;
            file_close(fp);
            wait until Clk_A'event and Clk_A = '1';
        end loop;
        wait;
    end process;
   

end behav;
