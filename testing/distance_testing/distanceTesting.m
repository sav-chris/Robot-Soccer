%Distance Testing

function distanceTesting()

ref=kiks_kopen([-1,9600,1]);

img=kLinVis(ref);
figure(2);
bar(img);
enc=EncodeImage(img);
figure(3);
bar(enc);

kiks_kclose(ref);
