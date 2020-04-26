require "./spec_helper"

describe Ms do
  # strings

  describe "#ms(String)" do
    it "should preserve ms" do
      Ms.ms("100").should eq(100)
    end

    it "should convert from m to ms" do
      Ms.ms("1m").should eq(60000)
    end

    it "should convert from h to ms" do
      Ms.ms("1h").should eq(3600000)
    end

    it "should convert d to ms" do
      Ms.ms("2d").should eq(172800000)
    end

    it "should convert w to ms" do
      Ms.ms("3w").should eq(1814400000)
    end

    it "should convert s to ms" do
      Ms.ms("1s").should eq(1000)
    end

    it "should convert ms to ms" do
      Ms.ms("1ms").should eq(1)
    end

    it "should work with decimals" do
      Ms.ms("1.5h").should eq(5400000)
    end

    it "should work with multiple spaces" do
      Ms.ms("1   s").should eq(1000)
    end

    it "should return nil if invalid" do
      Ms.ms("☃").should eq(nil)
      Ms.ms("10-.5").should eq(nil)
    end

    it "should be case-insensitive" do
      Ms.ms("1.5H").should eq(5400000)
    end

    it "should work with numbers starting with ." do
      Ms.ms(".5ms").should eq(0.5)
    end

    it "should work with negative integers" do
      Ms.ms("-100ms").should eq(-100)
    end

    it "should work with negative decimals" do
      Ms.ms("-1.5h").should eq(-5400000)
      Ms.ms("-10.5h").should eq(-37800000)
    end

    it "should work with negative decimals starting with '.'" do
      Ms.ms("-.5h").should eq(-1800000)
    end

    it "should not throw an error" do
      Ms.ms("53 milliseconds").should eq(53)
    end

    it "should convert msecs to ms" do
      Ms.ms("17 msecs").should eq(17)
    end
  end

  # long strings

  describe "#ms(Number, { long: true })" do
    it "should support milliseconds" do
      Ms.ms(500, {:long => true}).should eq("500 ms")
      Ms.ms(-500, {:long => true}).should eq("-500 ms")
    end

    it "should support seconds" do
      Ms.ms(1000, {:long => true}).should eq("1 second")
      Ms.ms(1200, {:long => true}).should eq("1 second")
      Ms.ms(10000, {:long => true}).should eq("10 seconds")

      Ms.ms(-1000, {:long => true}).should eq("-1 second")
      Ms.ms(-1200, {:long => true}).should eq("-1 second")
      Ms.ms(-10000, {:long => true}).should eq("-10 seconds")
    end

    it "should support minutes" do
      Ms.ms(60 * 1000, {:long => true}).should eq("1 minute")
      Ms.ms(60 * 1200, {:long => true}).should eq("1 minute")
      Ms.ms(60 * 10000, {:long => true}).should eq("10 minutes")

      Ms.ms(60 * -1000, {:long => true}).should eq("-1 minute")
      Ms.ms(60 * -1200, {:long => true}).should eq("-1 minute")
      Ms.ms(60 * -10000, {:long => true}).should eq("-10 minutes")
    end

    it "should support hours" do
      Ms.ms(60 * 60 * 1000, {:long => true}).should eq("1 hour")
      Ms.ms(60 * 60 * 1200, {:long => true}).should eq("1 hour")
      Ms.ms(60 * 60 * 10000, {:long => true}).should eq("10 hours")

      Ms.ms(60 * 60 * -1000, {:long => true}).should eq("-1 hour")
      Ms.ms(60 * 60 * -1200, {:long => true}).should eq("-1 hour")
      Ms.ms(60 * 60 * -10000, {:long => true}).should eq("-10 hours")
    end

    it "should support days" do
      Ms.ms(24 * 60 * 60 * 1000, {:long => true}).should eq("1 day")
      Ms.ms(24 * 60 * 60 * 1200, {:long => true}).should eq("1 day")
      Ms.ms(24 * 60 * 60 * 10000, {:long => true}).should eq("10 days")

      Ms.ms(24 * 60 * 60 * -1000, {:long => true}).should eq("-1 day")
      Ms.ms(24 * 60 * 60 * -1200, {:long => true}).should eq("-1 day")
      Ms.ms(24 * 60 * 60 * -10000, {:long => true}).should eq("-10 days")
    end

    it "should round" do
      Ms.ms(234234234, {:long => true}).should eq("3 days")
      Ms.ms(-234234234, {:long => true}).should eq("-3 days")
    end
  end

  # numbers

  describe "#ms(Number)" do
    it "should support milliseconds" do
      Ms.ms(500).should eq("500ms")
      Ms.ms(-500).should eq("-500ms")
    end

    it "should support seconds" do
      Ms.ms(1000).should eq("1s")
      Ms.ms(10000).should eq("10s")

      Ms.ms(-1000).should eq("-1s")
      Ms.ms(-10000).should eq("-10s")
    end

    it "should support minutes" do
      Ms.ms(60 * 1000).should eq("1m")
      Ms.ms(60 * 10000).should eq("10m")

      Ms.ms(-1 * 60 * 1000).should eq("-1m")
      Ms.ms(-1 * 60 * 10000).should eq("-10m")
    end

    it "should support hours" do
      Ms.ms(60 * 60 * 1000).should eq("1h")
      Ms.ms(60 * 60 * 10000).should eq("10h")

      Ms.ms(-1 * 60 * 60 * 1000).should eq("-1h")
      Ms.ms(-1 * 60 * 60 * 10000).should eq("-10h")
    end

    it "should support days" do
      Ms.ms(24 * 60 * 60 * 1000).should eq("1d")
      Ms.ms(24 * 60 * 60 * 10000).should eq("10d")

      Ms.ms(-1 * 24 * 60 * 60 * 1000).should eq("-1d")
      Ms.ms(-1 * 24 * 60 * 60 * 10000).should eq("-10d")
    end

    it "should round" do
      Ms.ms(234234234).should eq("3d")
      Ms.ms(-234234234).should eq("-3d")
    end
  end

  # invalid inputs

  describe "#ms(invalid inputs)" do
    it "should throw an error, when ms('')" do
      expect_raises(Exception) do
        Ms.ms("")
      end
    end
  end
end
