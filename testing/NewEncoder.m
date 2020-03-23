figure(5)
subplot(3,4,1); bar(img);
figure(5)
subplot(3,4,2); bar(EncodeImage3(img));
figure(5)
subplot(3,4,3); bar(EncodeImage(img));
figure(5)
subplot(3,4,4); bar(EncodeImage2(img));


figure(5)
subplot(3,4,5); bar(img2);
figure(5)
subplot(3,4,6); bar(EncodeImage3(img2));
figure(5)
subplot(3,4,7); bar(EncodeImage(img2));
figure(5)
subplot(3,4,8); bar(EncodeImage2(img2));

figure(5)
subplot(3,4,9); bar(img3);
figure(5)
subplot(3,4,10); bar(EncodeImage3(img3));
figure(5)
subplot(3,4,11); bar(EncodeImage(img3));
figure(5)
subplot(3,4,12); bar(EncodeImage2(img3));

figure(5)
subplot(2,2,1); bar(im1); axis([0.5 64.5 0 300]); title('Image 1'); xlabel('Pixel No.'); ylabel('Light Intensity');
subplot(2,2,2); bar(EncodeImage2(im1)); axis([0.5 64.5 0 5]); title('Image 1 : Encoded'); xlabel('Pixel No.'); ylabel('Categorization');
subplot(2,2,3); bar(im2); axis([0.5 64.5 0 300]); title('Image 2'); xlabel('Pixel No.'); ylabel('Light Intensity');
subplot(2,2,4); bar(EncodeImage2(im2)); axis([0.5 64.5 0 5]); title('Image 2 : Encoded'); xlabel('Pixel No.'); ylabel('Categorization');

kiks_kclose(ref); kiks_kopen(ref);	% Reset connection
im1 = kLinVis(ref);	

kiks_kclose(ref); kiks_kopen(ref);	% Reset connection
im2 = kLinVis(ref);	
