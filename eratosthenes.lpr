program eratosthenes;

const
  Index: array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);

var
  Primzahlen: array of byte;
  N, max, i, k, p, r, s, g: qword;
  Progress: byte = 0;
  F: Text;
  b, q: byte;
begin
  WriteLn('To what number shall the prime numbers be calculated?');
  ReadLn(N);
  N := (N + 3) shr 4;
  g := N shl 3;
  SetLength(Primzahlen, N);
  for i := 0 to Pred(N) do
    Primzahlen[i] := 255;
  max := Round(Sqrt(N));
  for k := 0 to max do
  begin
    for b := 0 to 7 do
    begin
      if (Primzahlen[k] and Index[b]) = Index[b] then
      begin
        r := (b shl 1) + (k shl 4) + 3;
        s := Pred((Sqr(r) shr 1));
        while s <= g do
        begin
          p := s shr 3;
          q := s - (p shl 3);
          Primzahlen[p] := Primzahlen[p] and not Index[q];
          Inc(s, r);
        end;
        if Progress < (100 * k) div max then
        begin
          Progress := (100 * k) div max;
          Write(Progress);
          WriteLn(' % done!');
        end;
      end;
    end;
  end;
  Write('Used RAM (approx.): ');
  Write(Length(Primzahlen) * SizeOf(byte));
  WriteLn(' Bytes');
  WriteLn('Writing to file... ');
  Assign(F, 'Result.txt');
  Rewrite(F);
  Append(F);
  WriteLn(F, 2);
  for i := 0 to Pred(N) do
  begin
    for b := 0 to 7 do
    begin
      if (Primzahlen[i] and Index[b]) = Index[b] then
      begin
        WriteLn(F, (b shl 1) + 3 + (i shl 4));
      end;
    end;
  end;
  Close(F);
  WriteLn('Press RETURN to exit.');
  ReadLn;
end.
