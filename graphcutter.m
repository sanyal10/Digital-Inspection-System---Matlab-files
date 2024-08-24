im = imread("14885350686496464.jpg");
info = imfinfo('14885350686496464.jpg');

[BW,maskedImage] = segmentImage(im);
imshow(maskedImage);

function [BW,maskedImage] = segmentImage(RGB)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(RGB) segments image RGB using
%  auto-generated code from the Image Segmenter app. The final segmentation
%  is returned in BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 02-Oct-2023
%----------------------------------------------------


% Convert RGB image into L*a*b* color space.
X = rgb2lab(RGB);

% Graph cut
foregroundInd = [2172 2402 2403 2622 2852 2856 3972 4422 4652 6002 6452 7572 9602 10272 10502 12302 12527 14102 14103 14327 14772 15453 15903 16127 17477 17703 17927 18153 18377 19053 19504 19954 20174 20177 20404 21304 21754 21977 22204 23327 24004 25356 25577 25806 26023 27156 27377 27606 28956 29177 29627 29856 30756 30975 31206 31656 33006 33225 33456 33460 33675 34806 35256 35706 35925 37056 37506 38175 38857 39075 39307 39525 40657 40874 41774 42457 42673 42907 43123 43357 43573 43807 44023 44257 44473 44922 44923 45365 45372 45607 47172 47407 47620 48520 48757 48970 49207 49420 51008 51219 52358 52808 53258 54819 55058 55060 55711 55960 56410 56860 57069 57310 58210 58660 58869 59110 59319 60207 60460 60669 60910 61119 61360 61810 62260 62469 62710 62919 63369 64060 64510 64705 64719 64960 65860 66069 66519 66760 66969 67210 67418 67660 67868 68560 68768 69218 69910 70118 70360 70568 71710 71918 72368 72610 72816 72818 73060 73266 73510 73716 74410 74616 75066 75760 75966 76210 76211 76416 76661 77766 78011 78216 78461 78666 79361 79566 79811 80016 80261 81611 81816 82061 82266 82511 83411 83861 84311 84514 85211 85661 85864 86111 86561 87461 87664 87911 88114 88361 88564 89464 89711 90161 90364 91061 91264 91511 91714 91961 91962 92164 92412 93312 93313 93514 93763 93964 94213 94414 95314 95563 95764 96013 96214 97363 97813 98263 99163 99613 99814 100063 100963 101413 101863 102065 103663 103866 104563 105463 106813 107263 107713 108613 109268 109513 109718 109963 110413 111068 111314 112664 113114 113564 114464 114914 115364 115814 116264 116919 117164 117614 118964 119414 120314 120520 120764 121214 121664 122114 122564 123014 123220 123464 123670 124364 124572 124814 126164 126372 126614 127064 127514 127964 128414 128623 128864 129314 130664 130874 132014 132464 133124 133364 134264 134474 134714 136064 136514 136964 137864 138074 138314 138764 138974 139214 139664 140097 140114 140544 140564 140994 141006 141007 141008 141014 141225 141894 141908 141910 141911 141912 141913 141914 142343 142575 142793 143025 143693 144141 144590 144591 145939 146175 146386 146387 146389 146835 147734 147735 147975 148184 149532 149981 149982 150430 150431 150677 151777 151780 152224 152226 152227 152673 153571 153572 154021 154277 155369 156268 156527 158068 158777 158968 159418 159677 159868 161218 162118 162377 163018 164819 165719 165977 167519 169127 169319 169577 169769 170027 170219 171377 171571 171827 173371 173627 174721 174977 175171 175427 176071 176521 176972 177224 177422 178772 179222 179473 180572 180822 181022 181472 181922 182822 183072 184622 185072 185322 185522 186422 186872 187322 187772 188672 189122 190472 190473 191373 192522 192723 193173 193872 194974 195426 196326 196776 197022 198126 199026 199272 199722 201072 201276 202176 202626 202872 203976 204426 204876 205122 205776 206022 206226 206676 206677 206922 207127 208027 208270 208477 208478 208928 210728 210730 211630 212080 212530 212770 212980 213430 213431 213881 214331 214781 215681 216581 216819 217931 218381 219069 219281 219731 220181 220631 221531 221981 222431 223331 223781 224469 224681 224779 224919 225368 225582 226032 226269 227382 227832 228282 229632 230082 230084 230768 231434 231884 232334 233234 233684 233916 235034 235484 235934 236834 237734 238184 239084 239085 239535 239765 239987 240887 241115 241337 241787 241789 242239 242689 243139 243589 244039 244264 244939 245389 245614 246739 247189 247414 248536 249436 249886 250112 250785 251012 251235 251685 251912 253935 254611 254834 255511 255734 256634 256861 257084 257534 258884 259334 259560 259784 260010 260234 260460 260684 261134 262484 262934 263384 264282 265182 265409 266082 266532 266982 268332 268334 268784 269234 270134 270135 270585 270587 271037 271937 271939 272159 272839 273059 273289 273740 274190 274640 275091 276441 276891 277109 277791 278009 278691 278909 279359 280709 283641 286107 286339 288357 292407 294207 296239 296457 299389 300506 301856 302539 303206 305689 305905 310405 312205 313105 314005 314905 315355 317603 319403 320753 321653 323003 323903 324803 328648 328649 328652 328654 328656 328660 328662 328664 328666 328670 328671 328675 328676 328677 328678 328679 328680 328682 328683 328684 328852 329136 329137 329139 329140 329141 329142 329592 329593 330943 333192 333642 333802 334541 334702 335152 336791 336952 337240 338140 339039 339202 340389 340552 340839 341001 341289 342189 342639 342640 343090 344890 345051 346240 346690 348649 348940 349099 350449 350740 350899 351349 351640 352540 354048 354340 354790 356297 357040 357940 358547 360190 360346 362439 362596 363789 364239 364396 364846 365746 366039 366196 366489 367389 367546 367839 368289 368896 369189 369639 369796 370244 370539 371439 372494 373689 375644 376390 377290 377444 379694 379991 380144 380891 381944 383294 383592 384045 384945 385094 385393 385395 385544 385845 385847 385994 387197 387794 388547 388997 390797 390944 391247 391697 391844 393194 393499 393644 393949 394544 394849 395893 397099 397549 397693 398593 399349 400249 400392 402949 403092 404299 404892 405199 405792 406099 407592 408799 408942 409247 409392 410147 410292 411497 411947 412092 412396 412397 412846 412992 413296 414342 414646 415996 416446 417039 417347 417797 418247 418839 419289 420639 421088 422438 423197 424097 425138 425897 426038 426347 426488 426797 ];
backgroundInd = [1286 1493 1736 2393 2636 4193 6443 6686 9836 10045 12297 13197 13647 14548 15448 15898 17248 18598 19948 21298 21748 23548 23998 25348 25798 26038 28948 29398 29848 30748 31198 32098 33448 33898 35249 35699 35938 37738 37949 39088 39299 39750 41100 41550 41788 42900 43350 45150 45600 46950 47400 48988 49200 49438 49650 50100 51000 52352 52802 53038 55288 55952 56402 56852 57088 58202 58652 60002 60452 60688 60902 61802 62252 62702 64052 64502 66088 67202 68102 69002 70352 70588 70802 71938 72838 73502 73952 74627 74638 75077 75752 76202 76652 76888 78002 78238 78452 78677 78902 80702 81602 81839 82052 83402 84089 84303 85653 86103 86106 86339 86556 87456 87906 88589 89256 90156 90379 91056 91739 91956 92406 93306 93756 94439 95106 95556 96006 96239 96907 97807 98039 98482 98707 99157 99607 99839 101407 101857 102083 103207 103657 104107 104557 105007 105239 105457 107257 107707 107935 107939 108608 109508 109739 110858 111085 111308 113108 113339 113558 114458 114689 114908 115589 115808 116708 116939 117158 117386 117608 117839 118958 119186 119188 119408 120308 120988 121208 121438 121658 121888 122108 122558 123008 123237 123688 124358 124808 125037 125038 125258 125486 126158 126838 127058 127288 127508 127736 127958 128408 128858 129308 130658 130886 132008 132458 132908 133808 134247 134249 134250 134258 134486 134708 135143 136039 136484 137185 137830 137832 138730 138731 139181 139631 139658 140531 141880 142358 143033 145478 146376 146633 146826 148176 149526 149783 149976 150426 151776 152224 152672 153572 153833 154022 154471 155371 155821 156271 156533 157169 157619 157883 158069 158968 159233 159418 159683 160583 161218 161933 162383 163467 163733 163917 165083 165265 165985 166435 167065 169764 170035 171385 171563 171835 172913 173363 173813 174085 174713 175435 175613 176510 176513 176960 177235 177685 178760 179210 179485 180560 181459 181735 182359 182809 183259 183535 183708 185058 185335 185508 186408 187137 187308 188208 188658 188937 189558 190737 190908 192258 193158 194058 194788 194958 196308 198108 198558 199009 199289 201089 202439 202889 203961 205139 206489 206663 206939 208013 208289 208913 209813 210263 210989 212063 212513 213863 216564 216839 219264 220614 221514 222414 222687 224214 224664 225114 228086 229165 230515 230965 231865 232586 233665 234117 239517 242485 244018 248068 251035 251218 257333 258869 260932 262919 264532 265169 271268 271921 272168 272632 273065 273721 276214 276682 278464 278932 279571 281164 282964 284071 288121 290164 290631 293971 296014 296481 298264 299821 302072 304114 304131 305672 308181 308822 310414 311314 311522 312214 313564 314014 315381 316922 317631 319416 320766 321216 321666 321872 322116 323016 325472 325716 330423 330681 331322 331326 331327 331328 331330 331334 331373 331374 331565 332235 332241 332273 332697 332721 332723 332915 333152 333171 333608 333610 333613 333614 333616 333617 333620 334073 334265 334973 336965 337223 337415 339023 339665 340565 341015 341031 342365 342623 342815 343073 343265 344181 344423 345065 345323 345965 346674 347331 348025 348215 348475 350015 350276 350726 351626 352076 352264 352526 354064 354327 354528 356127 356578 356764 357028 357677 358114 358378 359014 360178 360364 361528 361714 361727 362428 362878 363328 363514 363525 364228 365579 365764 366029 367564 368014 368464 368730 368914 368923 369182 369364 369814 370532 371605 372332 373682 374320 374752 375482 377468 377732 378182 379982 380168 380882 381332 381782 381947 383132 383582 385096 385996 386732 387182 387632 387796 388982 389432 389596 389615 391232 391682 391846 393032 393196 393482 394382 394832 394996 395283 395464 395733 396796 397247 397534 397697 398434 398597 398884 399334 399784 400234 400397 400414 401134 401748 402484 402664 402936 403098 404286 405186 405636 406248 406536 406986 406987 407148 407437 408337 408498 408514 408787 409237 411037 411198 411214 411648 412840 412998 413290 414348 414798 415090 415248 416891 417048 417064 417341 417498 418241 418398 418691 418692 418864 419142 419301 420201 420492 420651 420664 420940 420941 420942 421101 422001 426064 ];
L = superpixels(X,3691,'IsInputLab',true);

% Convert L*a*b* range to [0 1]
scaledX = prepLab(X);
BW = lazysnapping(scaledX,L,foregroundInd,backgroundInd);

% Create masked image.
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

function out = prepLab(in)

% Convert L*a*b* image to range [0,1]
out = in;
out(:,:,1) = in(:,:,1) / 100;  % L range is [0 100].
out(:,:,2) = (in(:,:,2) + 86.1827) / 184.4170;  % a* range is [-86.1827,98.2343].
out(:,:,3) = (in(:,:,3) + 107.8602) / 202.3382;  % b* range is [-107.8602,94.4780].

end
