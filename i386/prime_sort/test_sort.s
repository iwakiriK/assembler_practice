	section	.text
	global	_start
	extern	sort, print_eax
_start:
	mov	ebx, data
	mov	ecx, ndata
	call	sort
.loop:	mov	eax, [ebx]
	call	print_eax
	add	ebx, 4
	dec	ecx
	jnz	.loop
	mov	eax,1
	mov	ebx,0
	int	0x80

section .data
data:
dd 1929260771
dd 1771143779
dd 1238368216
dd 983616721
dd 550644850
dd 647884155
dd 919950540
dd 1863951655
dd 1467449583
dd 542640406
dd 96853898
dd 265584744
dd 492897109
dd 1156097162
dd 1905721526
dd 1550696739
dd 329656512
dd 19705311
dd 1570002289
dd 164124474
dd 15203900
dd 1328869522
dd 1718141163
dd 339826719
dd 426794417
dd 154926178
dd 505106721
dd 471288353
dd 117059954
dd 1740227372
dd 1788863998
dd 147103103
dd 16543203
dd 1181606427
dd 1629735648
dd 1410783023
dd 71011034
dd 1365613450
dd 1914140729
dd 1175249449
dd 782673412
dd 1817379031
dd 824099473
dd 1643793475
dd 155233942
dd 1478243260
dd 1455534524
dd 1078132180
dd 1619030230
dd 181079077
dd 313425071
dd 1109358061
dd 1206652185
dd 1623496594
dd 1268170676
dd 89161445
dd 1289869801
dd 1356041577
dd 1339236951
dd 588027259
dd 1460224507
dd 1144549972
dd 1279676344
dd 206746501
dd 179255373
dd 1003694145
dd 1175084595
dd 1301367258
dd 1337309122
dd 234408696
dd 355857723
dd 234718214
dd 195736415
dd 464517320
dd 1971396160
dd 346197490
dd 855772100
dd 553950332
dd 1114552660
dd 243209393
dd 1564549486
dd 1379148384
dd 845779331
dd 1311279427
dd 156773993
dd 1082544561
dd 686987301
dd 845561826
dd 1718095231
dd 1020607699
dd 1879230770
dd 35502017
dd 1277934407
dd 57267470
dd 1076356025
dd 579406956
dd 786461542
dd 1249329684
dd 1235356189
dd 1140437334
dd 749839844
dd 608681471
dd 1726234525
dd 635145336
dd 293278523
dd 285883692
dd 488843742
dd 1706468063
dd 1852625791
dd 15605157
dd 186826519
dd 192628048
dd 578206521
dd 1341973152
dd 431074025
dd 260516638
dd 441629611
dd 378250556
dd 354935208
dd 1706921459
dd 195874125
dd 1558504501
dd 114890615
dd 104733917
dd 1135876465
dd 1948558326
dd 1663941222
dd 1626614775
dd 1082098655
dd 670220513
dd 1707195695
dd 1939333456
dd 1360426091
dd 1358514602
dd 812959409
dd 233207996
dd 631737277
dd 1349595798
dd 837175952
dd 1719085510
dd 1243373887
dd 1551686297
dd 149737467
dd 557695989
dd 1998532520
dd 278395335
dd 559604524
dd 1731813076
dd 1690565395
dd 350164809
dd 1659750022
dd 660542533
dd 905831589
dd 653500050
dd 796805459
dd 1998560372
dd 1095848885
dd 278561191
dd 664332392
dd 1953816300
dd 1048074485
dd 1054306571
dd 179507693
dd 1268932286
dd 1091956368
dd 1518648989
dd 793588907
dd 699338883
dd 766461597
dd 382211405
dd 1575956264
dd 121431472
dd 1506869006
dd 682704042
dd 1575201269
dd 334273082
dd 1098227007
dd 1928392922
dd 280289034
dd 977447849
dd 262788490
dd 470543716
dd 68153057
dd 855657797
dd 1527459428
dd 1534307654
dd 825327858
dd 1198883446
dd 1339601595
dd 1214721104
dd 370777135
dd 137974005
dd 806428280
dd 1280020523
dd 691573747
dd 1863223603
dd 1121990755
dd 820282916
dd 1545423302
dd 762904423
dd 69888056
dd 1168691767
dd 803336203
dd 296193700
dd 459109095
dd 669952851
dd 1527434200
dd 708027560
dd 130849738
dd 871246443
dd 1634567523
dd 990968697
dd 588004025
dd 1692555405
dd 1924008058
dd 1071265033
dd 324823672
dd 1753455490
dd 1991113503
dd 1154230898
dd 1706739081
dd 981948178
dd 258917554
dd 900479097
dd 560553905
dd 128360513
dd 1092732587
dd 1793199462
dd 1430429362
dd 1105683871
dd 181944611
dd 152695498
dd 1338779646
dd 1960177515
dd 1447376140
dd 994083340
dd 623171513
dd 1557076290
dd 437281657
dd 825004873
dd 416575100
dd 1091517969
dd 191863150
dd 841237407
dd 171114831
dd 681297801
dd 1973040437
dd 1379274030
dd 1523334593
dd 1473968730
dd 67223272
dd 1287629711
dd 146685719
dd 845588794
dd 1474400121
dd 725376606
dd 75485489
dd 852775419
dd 3622780
dd 1211055858
dd 511243289
dd 1625612859
dd 815817073
dd 1232730673
dd 1190527047
dd 889577026
dd 1408928595
dd 876864720
dd 13209608
dd 1344444479
dd 1453109277
dd 1507509035
dd 467008997
dd 802842623
dd 1686606186
dd 1076787721
dd 1260983640
dd 427629196
dd 614119012
dd 1002966057
dd 1975579224
dd 263864178
dd 1252787776
dd 324792126
dd 1084713603
dd 727209295
dd 297048038
dd 1922902991
dd 697245565
dd 506862605
dd 378987910
dd 664706882
dd 248268077
dd 1219561222
dd 548450145
dd 1333371912
dd 248512399
dd 394967305
dd 1556084038
dd 880697634
ndata: equ ($-data)/4