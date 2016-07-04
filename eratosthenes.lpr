program eratosthenes;

{uses
  Epiktimer;  }

const
  Index: array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);

var
  // ET: TEpiktimer;
  Primzahlen: array of byte;
  N, max, i, k, p, r, s, g: qword;
  Prozent: byte = 0;
  F: Text;
  b, q: byte;
begin
  // ET := TEpiktimer.Create(nil);
  WriteLn('Bis zu welcher Zahl sollen die Primzahlen berechnet werden?');
  ReadLn(N);
  N := (N + 3) shr 4;
  g := N shl 3;
  // ET.Start;
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
       {  z := 0;
        t := 2 * Sqr(b) + 6 * b + 3;
        u := 16 * Sqr(k) + 4 * k * b + 6 * k; }
        r := (b shl 1) + (k shl 4) + 3;
        // s := 128 * Sqr(k) + 2 * Sqr(b) + 32 * b * k + 48 * k + 6 * b + 3;
        s := Pred((Sqr(r) shr 1));
        while s <= g do
        begin
         { p := u + 2 * k * z + ((t + (2 * b + 3) * z) div 8);
          q := (t + (2 * b + 3) * z) mod 8;
          q := s + z * r-8 * p}
          p := s shr 3;
          q := s - (p shl 3);
          Primzahlen[p] := Primzahlen[p] and not Index[q];
          Inc(s, r);
        end;
        if Prozent < (100 * k) div max then
        begin
          Prozent := (100 * k) div max;
          Write(Prozent);
          WriteLn(' % berechnet!');
        end;
      end;
    end;
  end;
  //  ET.Stop;
  //  WriteLn('Rechenvorgang beendet. Gebrauchte Zeit: ' + ET.ElapsedStr + ' s');
  Write('Verbrauchter Speicher (ungefähr): ');
  Write(Length(Primzahlen) * SizeOf(byte));
  WriteLn(' Bytes');
  WriteLn('Schreibe in Datei... ');
  Assign(F, 'Ergebnis.txt');
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
  //  ET.Free;
  WriteLn('ENTER zum Beenden drücken.');
  ReadLn;
end.
