local uv = require('uv');

p("uv", uv)


uv.fs_open("license.txt", 'r', 420, function (fd)
  p("on_open", {fd=fd})
  uv.fs_read(fd, 0, 4096, function (chunk, length)
    p("on_read", {chunk=chunk, length=length})
    uv.fs_close(fd, function ()
      p("on_close")
    end)
  end)
end)

uv.fs_mkdir("temp", 493, function ()
  p("on_mkdir")
  uv.fs_rmdir("temp", function ()
    p("on_rmdir")
  end)
end)

uv.fs_open("tempfile", "w", 420, function (fd)
  p("on_open2", {fd=fd})
  uv.fs_write(fd, 0, "Hello World\n", function (bytes_written)
    p("on_write", {bytes_written=bytes_written})
    uv.fs_close(fd, function ()
      p("on_close2")
      uv.fs_unlink("tempfile", function ()
        p("on_unlink")
      end)
    end)
  end)
end)
