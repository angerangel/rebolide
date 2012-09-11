REBOL [	
	TITLE: "Rebolide"	
	date: 05/09/2012
	credits: { Carl sassenrath, "Shadwolf", Steeve, Maxim, Coccinelle, Cyphre, Graham, Nick Antonaccio, Semseddin Moldibi, Zoltan Eros, R. v.d.Zee}
	purpose: { Colored IDE for rebol in rebol, for beginners that helps learning Rebol. 
	I suggest you to put this script in a separete folder.}  
	version: 6.4.49	
	File: %rebolide.r 
	Author: "Massimiliano Vessi" 
	email: maxint@tiscali.it	
	Library: [ level: 'intermediate
		platform: 'all 
		type: [tool demo ide] 
		domain: [all] 
		tested-under: [view 2.7.7.3.1 Windows Linux ] 
		support: maxint@tiscali.it 
		license: 'gpl
		see-also: none ] 
]








make-dir  %local/  ;make-dir tests if exists a directory and  if not exists it creates it
change-dir  %local
req_files: [ %scroll-panel.r  %simple-tooltip-style.r %lucon.ttf %resize-vid.r  ] ;requested files


foreach item req_files [
	if not exists? item [ request-download/to  to-url join http://www.maxvessi.net/rebsite/ item  item  ]	
	]
	
do %scroll-panel.r

do %simple-tooltip-style.r

do %resize-vid.r	
;this is useful if you are on linux
my-font: "Lucida Console"
if system/version/4 = 4 [my-font: to-local-file clean-path %./lucon.ttf ] ;Linux case

;***********************************************
; utility functions to lad and save user preferences

;saving preferences
sav-pref: func [][	
	pref/bg_color: b1/color
	pref/txt_color: b2/color
	save %pref.dat pref
	]

;loading preferences
load-pref: func [][
	if exists? %pref.dat [pref: do load %pref.dat]
	]

;see if there is a pref.dat file to use in order to load user preferences
either  exists? %pref.dat [
	load-pref
	][
		pref: make object! [		
			bg_color: 0.0.0 
			txt_color: 255.255.255
			]
		]
;end of utility functions		
;**************************************************		
		
;NOW SKIP TO THE CODE AT LINE 248. The folowing lines are just compressed scripts for tab panel and menu bar
;***********************************
; LOAD TAB-panel widget Cyphre (TM)
do load decompress #{
789CBD586973E2B816FDCEAF50577FE86428C7989824506F2695349DADB37496
4E4FA09C2A63CBE0C6D8C4368DC9BCF9EFEF5E495E65B2CCAB9AA4005BBAD2DD
8E8EAEF45714AF3CF799AA33338A6948868D47253647CADCF4A9D7238E6951B2
74E309EBE05D6648CD1E999953CABB79CFA312384E44E31E6925ED9668A2F698
0A517CCC441F1577666297179836890365E4FA66B82236B582D93CA4514476F4
8F7F35E8D973D8FF76F8DC69FEB8D56767E387ABBED63D39383B884FC79713EB
E4B8D38F2EEF9ED4A3969BCCFBBF76AE7E9E2E4757ABB079D3D28FADC99F8DDB
6F0FA77BB3FBF1D3D199F7703C0906B3BEDEBCE99EFE6A1F8EBFF6EFC70F27EE
FDF2E2707C39681F5EDF256A337A1ADCEB874FB7CF897DF2E5E2A9D171EFBA4D
4775FC78767D6D1E4D6EA6D6F5D765D4D793E3D9E0AC3B4816E777E7CFA74F17
9FA7AD9B2FC9F27C104C8F0E7FBA17DD4B6B7BFAE3B6D1FC71393BD8BB9AF447
30CF73D3695D7C3B595EDEDE3C58BB5F4EA3CF5DB77564FF79D78CC0BC643038
39F8BAFB5DBB3EBF98B9FDD1FDFC9BAD37BE3E07CBF3D3D5C21B3C75CD8BE6F7
B3B63538BE9C3E9CF8FABDF7BDD554E943AB75A21FDF6996EA6DDF5F7DFEDE3A
38D8D54E0F9AD303F8FBBDF17716F40812DD237AA293ACC90ABC20EC113FF0A9
6833C4AF4311003CCDF058C85DA3F4F3A884D40ECD258065E15B64E8109350A3
200E30000001B61C750ED8F1630561A38E82D0A6E17E4910B4AA0814953A0EB5
004B08872002E0D024A6BECD6CDF7054748428446B6D12E600BE6E94A767ED91
AA6D1A85F98D3A6525EF8B1110225553C6A169BBA00780AE9176A7BDC53F3A69
EBFA565BDFDE6A6FEFBDC72CA31478235D67754B8C27B0038ABB6996023F4E25
E1B1104D9159ADDDDA129F0A0E34AD92F1F5AB5546493A0998F266DC507FCC16
7D012744F502CBF448E43965C844403AD60444CA19B383A55F690259CFE955C0
55789685D594C55464B91E89A8071926A227620F4E602D229E06D7B769B24F1C
F84D65945190B0C1A016463B151DAE039E0D51D6B46237F071587956E335ABD4
BA900BD949B064B3A15CA9CFA805B1F1D2425D9300173B7F279F98AE72BCDF11
6D474DF78499EBE3982012DFCDCA0C76E0C495A12200E868BA684A1282544A61
0593DF902D09409C50D4558FB4DB521777013B5B521F2EB9D4D091675A531908
68433DD5F129EAE84EB5299D9321268B0CE7D4271BC5286C82739EA7D4B4839F
B820BB408C2DD88535A30AB35A3E0B8305C44AEBEC6D693B5DF874C876755CF9
DD581FBF8C97EAE227C7568A1F0063A71AE6F706B166C914FDAEF39720A7831D
8CD2351DD8927F8023E1977F5E89C98B4BAF48ED9C373323855B3D12870BDE52
A01EA4A31EB1CDD864CF0864781D99D31E31C33058463D22A257D9C83826C0D9
8F436C3320313B5B6D0DF6A64E879BB104BD28202C441D64E8D3A5CAB5396E18
C5C4876D17348DA3FC2975C90F84E97C54E686637A00AA5C927FBBBECB20375F
91D94ABCA5AA33C7E4FD2E2F2AF524470F9205EE3C850D2DA6F348CC3FCCC33F
33936C9BCA85EB2386FF7C3B28CF62E4560A0B916786D2BE6B14048B2572FA0A
254C757B2D0DC92320DE7213380ACA66C1A2F08398E4CC372CC0464BA5B84340
FB0B0C6A668AD050988BA79F238B29C2868A2E16373214E15B4EDC98A6120BE4
11C80AF9657A0B1223563C73455C3B210EB32E9ECD59260AD49136959323529B
271BE60087F28255184367F378B52FEC2EAC3DD854C016A9192012CCA8C41DA6
0F21057C71BBE1812D8B0F063E7237A23874FDF107D6802E0D47B05F4E3F90FF
9260F413F8049FC4986C32EEF2279610836C485C042EE0907D3E217CF5C8984F
2FF335C8328D4561F80A166BE4A151CD0F62552A65F3A1AF741FECE3B891444A
0C04E1AF1158F8E8279F41EAAE752255CA025DA733CB0278B05E234ABC4D2182
841D13EA94E5D8038AE0894B9B306A061AC10F194DA2ED25DBDB6FD109168680
1AD3F5186F67CB0E57417D6E11DAD80B4A5E9B2EAF61320E2A170B355E426F8F
540B2B116DDCAF7161B5B014635C8F4D0AC37C8187418F5AA0BAF41578888843
04AB343A6CB1F4C806FE6CCA9E3E2AC5FE9A6E991BDF1F711622B613088F7051
41DDE999515C0EE127B45D9A8E510F9258136F24E6A61B6629D4B228BD3C2791
AA844DE08768EACEDF502CA4A501E7119C2D63CD824CAA34DFDBCA19CE02C1FA
36D83CBF112D81A3729328DA0E948505695828305C4DC81F8443A202A4628899
9B69D9C139282DEEE0A83B86A8BC8848D30A8328AA348A81DB499B4473445C95
B1983EA2ED26DA2ED910956E7B937814F2149A31253B35D067DB51E54099FE3B
FC52EB8DA74511232493093581B2F30305475A9D0AAC364B5250DC626D5B697D
6524AF72CAEF2F42B36A9A844501323CD265B23522AF2FBDEAFB9A24416E27FF
284BFF384788D37D5EABBE3751B5E156FEFF704B50A8B3EEDF499451A60385E8
AD44694B65025FE26B2E205E3EDBD4DFFD08C190724EE2B70FC4618CD324A5D3
A438D463C8F7457FF5CA2E3D6AA64F901026A816CB06E9A28FAB6682EBC89785
5B722F33BE7A7512A45727B083BFE9EA846354A14F0BD34322C16A1B7FE45A75
E2DA9438B51E48875B474D2959EAB20332C26B104715672EDCB91CB0AC7A6355
719D252271E33581023FC4A583949BF42AA2974AD4F5BF78DFCA6A222CCA3476
67E4517F1C4F8AB42BEE71B212B5519C3FBB421348CB2F8AA1469124D3E9544D
45B4AAFC7EB2A24BED6185F6895D3C56EC6681E0D19722F1E2222A0808FD42AE
DCDCCE9B5352AD9F242DF8D39BF1F202AF8C29121C96803E1D2343D7788D3775
6AB266B86033AC6DD8D628F1617D8E44D4AA550C141EFF917995973065A7A088
D1BB50C4D45CE2554CABB36AED18F94E614D8C15A87813FC7A43452753A4D130
FEFE1F50628086731B0000
}

; LOAD MENU WIDGET Cyphre(TM)
do load decompress #{
789CB51B6B73DAB8F67B7E85BA3B770237430CE4D12EDD6EC6109A92266D499A
B629E3CE1810C6606C6A9BE074BBFFFD9E23C9B66CCB84A477C384C8B2747474
5E3A0FE5EF5118D516D45DB5C8C29C53E20D6774143E23839D6F357B615A3468
119F8E5723CABABED55EE260329C5B646D875342C71665FD8E678EC9F1E1EF7F
DB9FDAEFAFD6F5B76796A7C3CFBBEB9B69F7C68256BB87CFD71DFD161F3EFFF0
8EBE6047FB6CDCFE78D3D5F58BB3F7930FE1D5CE7C0DBD9DF6ECFAF5F93B787D
7CDED775AB77A9EB1F5C0D5EE8C7F07AFC11BEDE2F11ECB103E35F37F7BE7CFF
EADE20C09DE6DCE9F63F5D1DBA67172F34ED85A6FFB8D1FB7A27B27A33FFD38B
BDABAFE7DF17E1B43B5B4DA7B06AD7BABE3A773AEFDAD7FE7BC07074D5DDB1E7
776BC4D25B2EDB00BBFBEE1656F7ACC08AACAF67572BBDD9A6BDC6E7B6ADEB6F
BAD6FCC5E91B5B3F8F2EBFF6FBD142BFA6D6E71D58EDEAF8C7CDF2EB25ECA0D3
D1DFBEE95E754EEFDF74FA7AB7FBEEA67376DFD1BF9FDDF6FBFA69FBEEF6D68F
AE7A17BADEEB0DDB9DE69DFEFEEDCE17EB6BEFB6F7767D7EEE0125EF69AF1FE8
EDB61E5993FAE5349AF5828B4B86E17A31E97FBC9E863F7AFACDFBFACCBA38EF
996DA0FBCE6D70F5E58D7DE67EE94CFBFDD7A3D3C6C58B8B2BFDB2DB7D7D7C7A
AD03B5FBB7FAC5DC72BF1EDE6B07EDBECE5873F3E9FDD5DBA3CE6DAFF7EA1F89
D9A3291DCD413CFCF9969CD6D9578F73FAB47BFAFCF8E2DFE1F44D3DE6F4F97C
4FDFEBAE7AB0F41A609DBE99CED7FDB6A5B7EDFECAB4AE0F7B20017A74DBB7EC
B707CF3F009C7EFFEDF4F38ED75D74901A97D7AF7FD43B9FDAC8ACB3CBCE9ED5
EDB65FB70F6F75ABDFEF358EEE74EB3540EEEA7BF3E0CB878F079ED6EE3292ED
E46966C06F10DE3BF60FAA2DCC20A4BED01BAE6313131489290EEFFD561B798E
E7B788EBB954F44C3C3714DA88CD64643276E898A379D2E94D26018509F5A89E
F4055373ECAD33500DF117155640C7A6043D009C5BA41135F2EB359E37F71BC7
2FF61B4707DF6A39706BCF1F838948A18CCDD0240397AE356CC18E6D3F08894B
A39098BE15A42D2399623ACBA92981F856C3E9ACB7305F1A04066A42827BA0F1
421BAE6C678C2B52F22769366AE7A65B6BD6EB8719A839C8CDA323522324E9C9
8C34A4A70C62793C8C1C41BC498617410838B5083029E5376C8A711824A236C9
304960164F9E50EAC492004D69333EE5DC9AACDC11190019E069CF90374B41C8
40F896A6ED9F90898603C84034B4A895B4C81E9F0C2D79CFF1D078603C4C1E13
4CBD35991428912388EDDA612B2BC42D62BAF764C0C48B6D3F850A2C75BD90F0
57032180CD83E3FDE6C1C17EB3719C8E5C9A2E6037F2960029ED659445B5497B
3C9F9A2350389B0C0DC2C553DA84ED06D40F4968DA0E419082DCE688E6642704
D6B7889DE9E3CA243130A337857E3835F93BE9503DFC63BF513FDE6FFCF13C47
098EBB1B1666ACA73688393302C5D1B1B8A0DD301DDB725B64D7A193303B7269
FAA618894D80E99BCB13344F4E003E806F5B364C6C46F5EC342E1087D1214883
45C35AC84408D7B271C5CCD8D82C813E64FAB9551812FCC9625F2AEC02E01DF5
5381378967E44730E9311D986A82D4C2C628500F39A9312DCCF571F55300E1B6
5A0315A321CC4184156354C0346F19DA9E1B2858BF6152B85872ABA10629E858
59DBAE202AE873153850A9470DF25FA19F553065F5E870DB353927033AF2DC31
0940EE4FD4AB732563D695D9AB7887822E894CEE7285CDC2803EB28BD231D1D8
41B6CB0D7D7610EB33B6C55B9C29654CE1164931B130B6B8E244136ABBB4C1DB
9968A9B292E2527C47B91992B62AA6E4ACA51A0DEA5AA6456531A70A090DC083
008B661674842998B776952FF2241547139A5BC50B0500159756CB92B5401555
3AA81E0C16C99BE715945963DB1DD3088413FEAA5E8324536722AC066F0F5468
E2671BAD8E1905F82C574B0D740EC8A9996BF35E2956ADD2D342FE240AFECBBA
2C84447DEAC89FB2132823289B7549880C3B53F2C63D4356738426A1852702B0
2B4B27D079F6B67476A981798C7979BC71119C2E5A41C4A7743CC8346C50B89C
77365D935D90135CA9A63CB232847CE078933F78368E1C2FA0357A077B41FF9A
3D96EF84CF015FC61ED393C47C2003180483B75FF1270D1F1E82B5F4BD110D82
9AB70A1128C74405F90138F8B3721D00C59578B080839C84F68212148D3B5471
D198D37BC2AC5730F23DC7A93936F84302E5F07E097230454C986A3E843EFEB0
990F8C7B900CDEB236A6211D852DE0E153362F1C71C11B92CE7E5004721018F9
64B128210DF723C980A3B8C51AC6D698288542DAD2368BFD0243CADF95BD3118
D56ADC8E174EDFF8B336EDB0FCDC509E9ACC53564E508129F6E57BB2CFF293DC
16A74888274623AAC3895129F1C6C12456AB85D0EC5BEDE543364F0C38AED7A3
669A504093A5F1A093B0539687E5B17DE6FD6C621232C47F172B27B485E5636D
49DA26B643333665E8CC334A0516973957D04F1A393165ECE087184B49719460
A4927859B40C96AA81AF8470311AEC7510FAECAF961E7C136F38C3497C804FC3
95EFB22DB3C050E107A003844A9E49E70C672067312A22E152879F887D8B7E1E
69C638705459582D7248299ECC0B49CEEFF8EC640F041E44EF24CE56404BF42D
CD702A3A97A2C55D23DE74BC91E9B0E65D92E0F55760C4590BED329F0381E842
38D7E355DC0A5643DE630727AC319ACE79C35E58ECEFD0F44547B8607FC1F2B3
BF3402591CF377AE07E6920F172C8D43C9241309188340C95CC1E76C5200D8C0
3616B305741942DC847004B605C76BE0C1793440C0102F7B2EA960536BE0C304
1CB49F04BD4614C2219066FE8C543818EC010055783FB79706093D42DD315F98
E076EC30E16192DB40DA275282BB0CB2181B29E15BE4203A48C99BA65114C1F0
D843E72476C2B82E9818976C769D779937B28B001F31CBC41457925254052DBF
860E07F92884A84C3D2E982AF7BCE03C6F4CC0629E2A3172D4013700F52A753B
8DE4D478446E67DBAC4E2E7768A4CA9718F0ACDDFFEDF237C277AE2529B08CD0
81AEC7B2561766881D29A9962BD4834AF95DAE278951455A0C7641D1CDA14349
0535BE45427F45AB06A3D380E5F976E1B4421B205E8136EDD6E21E768E560D31
1CB50C8C0419B0D2D33318892704FE45FC9FC5C376C180900A5A91643536335C
A0D5B45DEB191FF73BEB46B75274C7F3C144910A33300900AEFB0916C21211BE
6134093F992D90314DED81412AD2A1C3625926B43CAB08946F908A8864719DAA
34384E59A1809C24CBB22E84CF90348C814853E26C8E471604235AE674147C67
843C89896A89A3125A598783BD0A3D5EF293B5466887E553EA92547738DC1683
4B2713748F4129C08B4A8A08E09B3051355E368E23396F9BF568004D9040ED1E
629383FC0EA4CC2CB7EC04F896D169F2127A588D0A9F732E15FAC580557C1CC9
9B15B86379536BBC64E2CEAB214390217349FE634D2216E2EF2F5D2B373BDEEE
C85B2CC117073F3B0AC1E813166B8283432A65468347A8CDA323A3CA13DCE835
958E96B2E3D5BCB7581EDE97E606D4E97289090119A439DB20DCCE218599A886
1B3807E4D7F27975C2EB8A63EAD80BB057BE9A710058BD6DA91EB5EDEE13574B
AA6E091396E6A9C18F06A7B774DF19F73B9F9FE1C6281F156448554A146EB213
B2E06306B6A047B19F5724C2450E4975E2DDF73CF42A73DA90398B44A089669C
0C061299659283319226955720BC7C098208F649B3B5E653EA12982B83238599
1730331008E51444442251B31819C11191A90E31A9111A1D47EA92C92C0820D3
796D4CE9920CC6BEB9164715BA4360E2175695D4F741C3F7EB464E81F2A0C462
780A2AC2EF0C6C0CF184B16A9680572C80BE65410FCAB51A04741C0903B14C82
03C1D6C79666088F20C88C848B25FE7AF815E0976D902C150B68C3A0B2F89A1F
6A35FA7D653A2719416AC822AACC673C2ABFFFA40C7F31CA57E6FCE532154FBE
A36A663CDB3809FA0A5E025BD4099AF2792D3EAD300742928A0A12F4CFD2AA73
EE4D5C3F75B96CB08045890FC12F803303ADCB5BD9FCCE2B0E78F8E1F484235A
257FBE2249975B65647193DD6FCCAC7307AE74048421C9415D0107074C638DF9
C2E2C89D79109E0C7621F0406292DD4CEE1A3D6003F1C97B5CD98F4F594ED30C
057166A52319756AA5D4512D414A324A55456745D127EC4CD6A1243CBC050AB3
9D95E4FF4AD3829BC98E32A3F1B43F999448221B97C4C9998D0D54BD6011D5DD
6A188AF594F42A2D5DA1D92AABA115B44E594C2D8CDA504A2D8C55153F846F28
46F3334B7889E8472A0AADEA19B19F5A26CF42602A251B65374614EF44910B5E
436CC7E3F624F89732B0E08F6385AB4AFE22F50D69676081642294B44410F994
60414C3DB55993463063A95C406B8AE23BDBF231D90CC756C249A8B261726C60
6D7ECBA9049B8D3B4DB8868800B2B68CB91DF3ED2FF2105F1E5824DE285BA526
AF524B567900403AA7C5FD8274261279E3EC8DE51625F03DEE76D41E02BCF12D
1792ADF6C7252E4563C3E027D432CAB7AF7205124A3C412CCB5040B5E47BE492
C4BF379A3C38DB376A7A2AFD4F117C99E319A1378781E7AC42CAE4E0D1A4FE05
8A72992B5FF297CE8F47B24B5C87C983528EDED2C9D85CB7FA3F5E6099C49536
F022CA2E9EB03B26E25E49DEE530480A41EDBCB15B1D83CDA3B62FD32519371E
3DE7E6C57724A452D79DE9AC681C28452C32F5E154264A874DE5A2257EADCAB3
D9E0EA32D7B6D4DB85D80FFDDDE28D8D2D02CE38B0F35CE75E89166C92DF81D6
3077A118C0D3CF6C448953C4CA354A09CEE5A6B39F48DC39DDDD63E96783D1BB
126189870B2344A31313738CD047067B301206D57082610CA04FE970E3E72789
5AB9B21082C0B250E90CAC16A9B550949054CAA85415520119C92F14D7DAD574
5CC48A9248E12F887D2E1988B9F6C7E602C14AF9E1681516135F49EA2BAE0FA6
9FF20CE813EFB666925752112549812B2EDC6E4838F2DC5C116F6EEB9B8AD414
922E5FBC493FE2F0B96FF174791EF55C82262DC6AA39086B15B0CE7172B3FD79
98ABA6EFC3E153CE52F67E6BA696D239CEDD0DF87AF5FDE7F00B1FE27BEC5CF8
A3C0E64285E25FA474194DE3320FC6DFAEA1222DB7A18CBE3CA9A04CCCB14A13
D697E25889D79AF68863825F961FAD28A8F0407412B00B0149448A28629A9B9D
1808B25E128C4A858A5D9E5E4DF5261B84A605906DEEB6F0DB9095B20CAEB44C
55B67D80774148784D32D7C9CA5DB93E5E8FCC750A4615FA45ED30D39B629231
F0F11E25C3CEBBC41D92F412C30EBBE4C13204995B1EE9058FF45E867C3323BD
1921DFCDE0D1C84E725067FE312577BBE0A1A23262A03552BB943AED99FFA7B0
852B5B6902F7D81278B735E3D8DAB21F2B7BEF7238920BA3EEF3C3EFE597B082
ACA8316A33B194FC0F4EDCEB9C891B73123B8BC7D62C1358A4898F38807E8040
79F1CE5F8A5253AAD26477BA18373653EE49BB44B5891369E93EE37F084A7659
93B0D222BC8C7CA8DC1378B5CCE66E41B81A99A54D01B8042696F69F80E28B52
24C4202067732BD6487628BE646727D7B20587528E714B85025B2DAAB6505CE9
F69674D5077ACCF13873A72BBDFD1697FB714A72A52D003F4943CBA2C141A2A1
B30D5E5D6C99F9D04301C9244363202209FC77431B040804940CD96F930C307B
8BB782C12732E21B663C8F5D82914872B36B38325AB011E325D6BFBD0989FF97
78E79FFF0120649CE6573C0000
}
; END of ctx-menu

;area-tc is the main and most imortant face of all script

area-tc: context [	;** global context

; this set colors for every type 
colors: [
	char!		0.180.40
	date!		0.120.150
	decimal!	0.120.150
	email!		0.200.40
	file!		0.200.40
	integer!	0.120.150
	issue!		0.180.40
	money!		0.120.150
	pair!		0.120.150
	string!		0.180.40
	tag!		0.180.40
	time!		0.120.150
	tuple!		0.150.150
	url!		250.120.40
	refinement!	160.120.40
	comment!	255.150.0
	datatype!	225.0.200
	function!	0.255.255
	native!		255.255.0
	action!		0.255.255
	error!		255.0.0
	multi!		0.180.40
	free-text!	0.0.200
]

insert tail colors compose [ block! (pref/txt_color) default! (pref/txt_color) ]

multi-chars: complement charset "^^}^/^-"	;** to detect end of rebol strings

save-color: color: start: end: out-style: x: str: type: f: value: multi: grow?: none

;** markers used in replacement of the draw comman PUSH. Much easy to track them.
expand:		;** marker for info messages (like errors)
hilight: 'push	;** marker for hilight background
no-edit: edit: 'aliased

edit-mode: none

abs-x: 0
;** rule to output draw dialect
;gen-draw: to-block end
gen-draw: [end: (
		str: copy/part start end
		unless tail? str [
			color: any [
				select colors type 
				color 
				select colors 'default! 
				0.0.0 ; this is the deafult color if the others are none
				]
			either save-color <> color [				
				insert out-style reduce [
					'pen color 'text 'edit   (as-pair x * f/x + f/xy/x + f/origine-x 5 ) str 
					]
				loop 6  [out-style: next out-style] ;since we inserted 5 items, this weay we go toinsertion point
				][ 
				insert tail pick out-style -1 str 
			]
			if type = 'error! [
				out-style: insert/only insert out-style 'expand 
					reduce ['pen red 'text 'vectorial as-pair x * f/x + f/origine-x 5 + f/y reform [value/id value/arg1]]
			]
			x: x + length? str
			save-color: color
			if type = 'error! [grow?: true]
		]
	)]
	
	tab1: next tab2: next tab3: next tab4: "    "	
	what: none
	gen-tab: [(
			what: pick [tab4 tab3 tab2 tab1] x // 4 + 1		;** align tabs
			out-style: insert insert insert out-style 
				[text edit] as-pair x * f/x + f/xy/x + f/origine-x 5 what
			x: x + length? get what
			save-color: none
	)]
	
	spaces: exclude charset [#"^(1)" - #" "] charset "^/^-" ;** treat like space
	braquets: charset "[]()"

	;** rule to detect rebol values (uses load/next)
	;** (heavy, because we handle errors too)
	rebol-value: [skip (
		error? set/any [value end] try [load/next start]
		either error? :value [
			value: disarm :value
			either value/arg2/1 = #"{" [
				end: any [find start newline tail start]
				type: 'multi!
				multi: case [
					multi < 2 [3]
					multi = 2 [4]
					'else [multi]
				]								
			][
				end: skip start length? value/arg2
				type: 'error!
			]
		][
			case [
				path? :value [value: first :value]
				all [word? :value value? :value][value: get value]
				any-string? :value [
					if find/part start newline end [
						end: find/part start newline end
						multi: case [
							multi < 2 [3]
							multi = 2 [4]
							'else [multi]
						]
						type: 'multi!
					]
				]
			]
			type: type?/word :value
			color: none
		]
	) :end
	]
	
	no-tabs: complement charset "^/^-"
	gen-to-end: [any [some no-tabs | end: tab :end gen-draw some [tab gen-tab] start:] gen-draw]
	any-char: complement charset " ^-"
	
	set 'colorize func [
		face line out 
		/local check-multi check-free-text orig lvl-start lvl val cont pline pos
	][
		color: save-color: grow?: none
		f: face
		x: 0
		orig: out-style: out

		;** multi = -1, free text before REBOL header
		;** multi = 0, code not parsed
		;** multi = 1, normal code 
		;** multi = 2, end of multi-line string
		;** multi = 3, begin of multi-line string
		;** multi = 4, full multi-line string
		
		lvl: lvl-start
		multi: case [
			head? line							[-1]
			2 < val: first pline: pick line -1	[4]
			val = -1							[-1]
			'else								[1]
		]
		lvl: lvl-start: either pline [pline/3/2][1]
		line: line/1
		
		check-multi: either multi = 4 [none][[end skip]]
		check-free-text: [(cont: either multi = -1 [none][[end skip]]) cont]
		
		;**all [char? line/2 print line]
		parse/all line/2 [
			start:
			check-free-text "rebol" any #" " #"[" (multi: 1) end skip 
			| check-free-text (type: 'free-text!) gen-to-end
			| opt [
				check-multi start: some [
					some multi-chars
					| #"^^" [skip | end]
					|  end: tab :end (type: 'multi!) gen-draw some [tab gen-tab] start:
					| #"}" (multi: 2) break	;** end of multi-line
					| break					;** newline
				] 
				(type: 'multi!) gen-draw
			]
			any [
				start: [newline | end] break
				| some spaces (type: 'blank!) gen-draw
				| tab  gen-tab
				| [#"[" | #"("] (type: 'block! lvl: lvl + 1) gen-draw
				| [#"]" | #")"] (type: 'block! lvl: lvl - 1) gen-draw
				| #";"(type: 'comment!) gen-to-end  
				| rebol-value gen-draw
			]
		]
		
		line/1: multi
		line/3: as-pair lvl-start lvl  
		
		
		f/h-scroller/max-x: max f/h-scroller/max-x x * f/x + f/origine-x + (f/x * 10) 
		f/cursor/len: x
		
		case [
			empty? orig [ ;** if the text contains no chars, add a dummy line
				append orig compose [text edit (as-pair f/origine-x + f/xy/x 5) (copy "")]
			]
			not same? back start find/reverse start any-char [
				insert insert insert tail orig 
					[pen blue text no-edit] 
					as-pair x * f/x + f/origine-x + f/xy/x 5 
					"°"
			]
		]	
		grow?   ;** notices if it's a simple line or a double-size line
	]
	
	;** cut text into lines
	set 'build-data func [
		text f /local out
	][
		out: f/data
		clear out
		parse/all text [any [pos: (out: insert/only out reduce [0 pos 0x0] ) thru newline]] 
		f/origine-x: f/x * (1 + length? to string! length? head out)
		recycle
		out: head out
	]

]

;** boxline: [pen red fill-pen red box 0x1 32x18]

;** debug: display where show occurs
;show: func [f][print either in f 'cursor ['area-tc]['cursor-only] system/words/show f]

;** markers used in replacement of the draw comman PUSH. Much easy to track them with parse.
expand:			;** marker for info messages (like errors)
hilight: 'push	;** marker for hilight background
no-edit: 	;** marker for text no editable
edit: 'aliased
render-text: func [
		f inc
		/stay
		/local pos char color draw-txt
		prev-col draw-sblk nb line data n decal
	][  
		;start: now/precise
		prev-col: none
		case [
			stay [
				inc: inc - 1
				data: skip f/data inc
			]
			inc < 0 [
				inc: negate min abs inc ((index? f/data) - 1)
				data: f/data: skip f/data inc
			]
			inc > 0 [
				inc: min max 0 ((length? f/data) - f/nb-lines) inc
				data: f/data: skip f/data inc
			]
			'else [data: f/data]
		]
		
		draw-txt: any [find f/effect/draw 'push tail f/effect/draw] 

		case [
			stay [
				draw-txt: clear skip draw-txt max 0 inc * 4
				nb: min f/nb-lines f/nb-lines - inc  
			]
			empty? draw-txt [
				nb: f/nb-lines
			]
			inc > 0 [
				remove/part draw-txt 4 * inc
				draw-txt: tail draw-txt
				nb: min f/nb-lines inc
				data: skip data either f/nb-lines > inc [f/nb-lines - inc][0]
				;** A FAIRE, si inc dépasse le nombre de lignes affichées,
				;** parser les lignes skipées (non affichées)
				;** pour détecter les strings multi-ligne
			]
			inc < 0 [
				clear skip draw-txt max 0 4 * (f/nb-lines + inc)
				nb: min f/nb-lines abs inc
			]
			'else [return true]
		]
		nb: min nb length? data
		n: 1
		decal: as-pair 0 f/y
		while [n <= nb][
			line: at data n
			draw-txt: insert draw-txt 'push
			draw-sblk: insert insert insert make block! 50 
				[hilight none pen 128.128.128 text no-edit] as-pair f/xy/x 5
				reverse copy/part reverse head insert change clear "" "       " (n - 1 + index? data) (f/origine-x - f/x / f/x)
			if colorize f line draw-sblk [
				decal: as-pair 0 2 * f/y
			]
			draw-txt: insert insert insert/only draw-txt head draw-sblk 'translate decal
			decal: as-pair 0 f/y
			n: n + 1
		]   
		
		set-y f 5   ;** recalc all y offset of texts (which can be absolute only)
		unless f/cursor/selection? [show f]
		;** probe difference now/precise start
	]

	set-y: func [f y /local blk pair line idx gb lgb chg-y][
		blk: f/effect/draw
		blk: find f/effect/draw 'push
		lgb: index? f/data
		gb: f/cursor/global-idx
		idx: 2
		f/cursor/show?: false
		chg-y: [thru 'text ['edit | 'no-edit] pair: pair! (pair/1/y: y)]
		foreach [cmd value] blk [
			switch cmd [
				translate [y: y + value/y]
				push [
					if gb = lgb [
						f/cursor/xy/y: y
						f/cursor/data: at blk idx
						f/cursor/show?: true
					]
					parse value [
						any chg-y
						any [thru 'push into [any chg-y to end break]]
					]
					lgb: lgb + 1
				]
			
			]
			idx: idx + 2
		] 
	]

	move-x: func [f x /local blk pair chg-x][
		blk: f/effect/draw
		blk: find f/effect/draw 'push
		chg-x: [thru 'text ['edit | 'no-edit] pair: pair! (pair/1/x: x + pair/1/x)]
		foreach [cmd value] blk [
			switch cmd [
				translate [x: x + value/x]
				push [
					parse value [
						any chg-x
						any [thru 'push into [any chg-x to end break]]
					]
				]
			]
		]
		f/cursor/xy/x: f/cursor/xy/x + x
	]
	
	
	;** return the inner face matching the point
	map-inner: func [face point /local pane][
		unless pane: face/pane [return face]
		unless block? pane [pane: to block! pane]
		foreach face pane [
			if within? point face/offset face/size [return map-inner face point - face/offset]
		]
		face
	]

	get*: func [v][do back change/only [none] v]	;** if v is a word, get value in the world
	any-char: complement space: charset " ^-"

context [
	origin: off-mem: save-size: 0x0
	drag: track: false

	;** find a free place in the whole area to display the info box
	find-free-places: func [
		f 
		/local data end x len l-len r-pos stack-l stack-r
	][
		stack-l: clear []
		stack-r: clear []
		data: f/data
		loop len: f/nb-lines [
			line: data/1/2
			end: any [find line newline tail line]
			
			;** length of the left free zone
			pos: any [find/part line space end line]
			l-len: -1 + index? pos
			
			;** start of the rigth free zone
			pos: ant [find/reverse end any-char end]
			r-start: index? pos 
		
			stack-l: insert stack-l l-len 
			stack-r: insert stack-r r-len 
			data: next data
		]
			x: maximum-of stack-l
			loop len [
				
				stack-l: next stack-l	
			]
		
	]

	insert-event-func func [face event /local tmp][
		;print [event/type event/key]
		switch event/type [
			time   none	;** a lot of time events are sent, check it first
			key	[	;** key handler for faces without text and caret (actually only for areat-tc)
					if event/1 = 'time [return event]   ;** FUUUUUCK, why we receive that crap event here ???
					if all [
						tmp: system/view/focal-face
						in tmp 'style
						tmp/style = 'area-tc
					][
						tmp/feel/engage tmp 'key event
					]
			]
			move [
				either drag [
					tmp: track/offset
					drag/feel/drag drag event/offset - origin
					origin: origin + track/offset - tmp	;** correct the origin, if the tracked face has moved
					return false							;** disable move event
				][off-mem: event/offset  ]				;** for mouse wheel motion
			]
			resize [
				tmp: negate saved-size - saved-size: face/pane/1/size	
				
				;faces inside tab-panel must be resized before the tab-panel is resized and redrawn in the loop below --cyphre
				panels: reduce [core_sp vid_sp draw_sp  yv_sp]				
				
				foreach item panels [					
					item/resize/y  (item/size/y + tmp/y)
					]


				foreach fa face/pane/1/pane [
					if in fa/feel 'resize [fa/feel/resize fa tmp]					
				]
			]
			down [
				face: map-inner event/face event/offset					
				if in face 'var [ ;ATTENTION the following commands must be applied only to t (areta-tc) and his v and h scrollers
				if  any [face/var = 't
					face/var = 'v-scroller
					face/var = 'h-scroller
					][
					if in face/feel 'drag [
							;** the draging face which contains the pointer may be different from the draged (track) face
							drag: face
							origin: event/offset
							track: drag/feel/drag/track drag event/offset
							]
						]]	
					
			]
			up [drag: false]
			scroll-line [
				face: event/face
				face: map-inner event/face off-mem
				if in face/feel 'scrollwheel [
					face/feel/scrollwheel face event off-mem - win-offset? face
				]
			]
			active [saved-size: face/pane/1/size]
		];[print [event/type event/offset]]
		event
	]
]

;scroller function
scroll-panel-vert: func [pnl bar][
	pnl/pane/offset/y: negate bar/data * (max 0 pnl/pane/size/y - pnl/size/y) show pnl
]	

key-to-insert: make bitset! #{
	01000000FFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
}

stylize/master [
; list of function widget
	func-view: box with [
		edge: [ size: 1x1 color: 'black]
		;offset: 0x0
		;delay: 0
		current-line: 1
		tmp-data: []
		pane: []
		;effect: make effect [ draw: []]
		create-list-data: func [f /local n nblines line dt rule ] [
			n: 1 nblines: length? f/data
			clear self/tmp-data 
			dt: head f/data
			while [ n <= nblines ] [
				line: second dt/:n 
; on ne prend que du debut de la ligne jusqu'au premier newline
;ou jusqu'a la fin du buffer.
				line: copy/part line any [ find line newline tail line ] 
; example donné  par Steeve
; parse t [ some [ copy str thru ":" "func" (print str) | thru newline ]]
				rule: [ 
					some [
							"set" "'" copy tmpstr thru " " [ "func" | "function" ] 
							(unless find tmpstr ";" [ insert/only tail self/tmp-data compose [(tmpstr) (n)]])
							| copy tmpstr 
							thru ": " [ "func" | "function" | "make function!" | " does" | "use" ]
							( unless find tmpstr ";" [ insert/only tail self/tmp-data compose [(tmpstr) (n)]] ) 
							| thru end
						]
				]
				parse line rule		
				n: n + 1
			]
			;probe self/tmp-data
		]
		feel: make feel [
			resize: func [f size+][
				probe "resize event de la liste /My Funcs/ "
				f/size/y: f/size/y + size+/y - 5
			]
			detect: func [face event] [
				switch event/type [
					scroll-line [
						scrl/data: either event/offset/y > 0 [min 1 scrl/data + .05] [max 0 sscrl/data - .05]
						scroll-panel-vert bx1 scrl show scrl
					]
				]
				event
			]
		]
		render-list: func [  /local dt n nblines line ind lay ] [
			dt: head self/tmp-data  
			n: 1
			nblines: length? self/tmp-data 
			lay: make block! [ origin 0x0 space 0x0 backdrop white]
			;self/data: make block! []
			while [ n <= nblines ][
				insert tail lay  compose/deep [ text (first dt/:n) [ t/goto-line (second dt/:n) ]]	
				n: n + 1
			]
			;probe lay ; halt
			bx1/pane: layout/offset lay 0x0
			; support du scroller attention mode boucherie
			scrl/data: 0
			scrl/redrag bx1/size/y / bx1/pane/size/y
			show self 
		]
		
		draw-list: func [ f ] [
			;1) construit la liste interne des données [ "toto" 6  "titi" 14  etc.. nom-function indice_ligne]
			;2) dessine a l'écran les entrée que l'on peut affiché uniquement	 
			create-list-data f
			render-list
			recycle
		]
		append init [
			insert self/pane layout/offset compose [
				origin 0x0  space 0x0 across
				bx1: box white (as-pair  self/size/x - 15 self/size/y ) 
				scrl: scroller (as-pair 15 self/size/y) [ scroll-panel-vert bx1 scrl ]
				] 0x0
			bx1/pane: make block! []
		]
	]

; arec text color 
			area-tc: box with [
			style: 'area-tc
			rate: 1
			text: none
			para: make para [origin: 0x0 margin: 0x0]
			delay: 0
			ask: 'recycle	;** command to delay
			color: pref/bg_color
			x: 8				;** current x size oh 1 char
			y: 18				; ** current y size of a line
			origine-x: 3 * x   ;** stock la position a la quelle le texte démarre apres le rendu des numéro de ligne
			data: [] 
			fnt-sz: 14			
			font-obj: make face/font compose [ name:  (my-font) style: none  offset: 0x0 size: 14 align: 'left valign: 'top ]			
			nb-lines: 0
			xy: 0x0		;** scroll offset
			move-offset: 0x0
			effect: [draw [pen none font font-obj line-width 0 translate xy]]
			open-file: func [ file [file! none!] /local ][
				if any [file file: first request-file][ 
					;** data: build-data detab/size read file 4 self
					data: build-data read file self
					render-text/stay t 1
					feel/inc-font-size self 0  ; on replace le curseur apres chargement du fichier 
					;l/draw-list self
				] 
			]
			new-file: func [][
			file-name: %temp.txt
			tmp: "Rebol []"
			loop 30 [append tmp newline]
			write file-name tmp
			data: build-data (read file-name) self  
			render-text/stay self 1
			feel/inc-font-size self 0			
		]
		write-file: func [/local str-tmp n line nbline dt] [
			dt: head data
			str-tmp: copy "" 
			n: 1 
			nbline: length? dt
				while [n <= nbline ] [
					line: second dt/:n ; on transfert le  pointeur vers le document dans data vers un autre pointeur  
					append str-tmp copy/part  line any [ find line newline tail line] ;on copy jusqu'a newline ou jusqu'a la fin 
					append str-tmp newline
					n: n + 1
			]			
			write file-name str-tmp	
		]
		save-file: func [/local dt ] [
			dt: head data
			if 0 <> length? dt  [
				either  none? file-name [ ; data is full but we don't have a file-name
				    if   file-name:  request-file/save/title "Save as..." "save" 
				     [ 
				     if block? file [file:  first file]
				     write-file ]
				     
				] [	
				; data is full and we have a file name
					write-file
				]	  
			]				
		]
		run_scr: func [] [
			save-file
			;call/console rejoin [ pref/consol_path file-name ]
			launch file-name
		]
		search: func [ f-what [string!] /local dt n nline line str-tmp  move-to current-line ][
			current-line: index? data
			str-tmp: ""
		    n: 1 
		    dt: head data
			nline: length?  dt
			while [ n <= nline ] [
				line: second dt/:n
				str-tmp: copy/part line any [ find line newline tail line ]
				if find str-tmp f-what [ 
					either current-line < ( n - 1 ) [
					 move-to: n - 1
					 ;current-line: n - 1 
					 render-text self current-line
					][
						move-to: n - ( current-line + 1 )
						;current-line: n 
					 	render-text self  move-to
					]
					break 
				] 
				;probe n render-text self (n - 1) break ] 
				n: n + 1 
			]
		]
		search-next: func [ f-what [string!] /local str-tmp dt n nline line move-to  current-line] [
			; l'idée c'est de se servir de la position ligne courante
			; 
			current-line: index? data
			n: current-line + 1
			dt: head data
			nline: length? dt
			while [ n <= nline ][
				line: second dt/:n
				str-tmp: copy/part line any [ find line newline tail line ]
				if find str-tmp f-what [
					;probe str-tmp
					move-to: n - current-line
					;current-line: n 
					render-text self move-to
					;probe reduce [n current-line move-to ] 
					break 
				]
				n: n + 1
			]
		]
		search-prev: func [ f-what [string!] /local str-tmp dt n nline line move-to current-line ][
			current-line: index? data
			nline: 1 
			dt: head data 
			n: current-line - 1
			while [ n >= nline ][
				line: second dt/:n
				str-tmp: copy/part line any [ find line newline tail line ]
				if find str-tmp f-what [
					;probe str-tmp- 1
					move-to: n - current-line 
					;current-line: n 
					render-text self move-to
					;probe reduce [n current-line move-to ] 
					break 
				]
				n: n - 1
			] 
		]
			
			
			
			goto-line: func [ line-gt /local move-to current-line][
			   current-line: index? data
				either line-gt > current-line [
					move-to: line-gt - current-line
					current-line: line-gt
				][
					move-to: negate current-line - line-gt
					current-line: line-gt
				]
				;probe move-to
				render-text self move-to
				show self
			]
			
			v-scroller: make face [
				offset: 0x0 size: 13x0 color: none edge: none
				var: 'v-scroller
				size-box: 0x0
				para: none 
				effect: [draw [pen sky line-width 2 fill-pen none box 0x0 size-box 2]]
				feel: make feel [
					redraw: func [f a /local p l][
						if all ['show = a p: f/parent-face 0 < l: length? head p/data][
							f/size/y: max 25 p/nb-lines / l * p/size/y
							either (l - p/nb-lines) = 0 [  ;This is to avoid a strange bug of divide by zero
								f/offset/y: (index? p/data) / 1 * (p/size/y - f/size/y)
								] [f/offset/y: (index? p/data) / (l - p/nb-lines) * (p/size/y - f/size/y)]							
							f/size-box: f/size - 2x2
						]
					]
					drag: func [f offset /track /local coeff][
						f/parent-face/delay: 3  ;** don't perturb the scroll please
						if track [return f]
						if 1 <= abs coeff: offset/y / (f/size/y / f/parent-face/nb-lines) [
							render-text f/parent-face to integer! coeff
							if f/parent-face/cursor/selection? [
								f/parent-face/feel/expand-selector f/parent-face/cursor 
								show f/parent-face
							]
						]
					]
					engage: func [f a e][false] ;** don't send events to the area
				]
			]
			h-scroller: make face [
				offset: 0x0 size: 0x13 color: none edge: none
				var: 'h-scroller
				size-box: 0x0
				text: none
				edge: none
				font: make font [align: 'right size: 10 style: 'bold color: red]
				para: make para [origin: 0x0]
				max-x: 1
				effect: [draw [pen sky line-width 2 fill-pen none box 0x0 size-box 2]]
				feel: make feel [
					redraw: func [f a /local parent][
						if 'show = a [
							f/show?: if f/max-x > f/parent-face/size/x [
								parent: f/parent-face
								f/offset/x: to integer! negate parent/xy/x / f/max-x * parent/size/x
								f/size/x: to integer! (parent/size/x ** 2) / f/max-x 
								f/size-box: f/size - 2x2
								true
							]
						]
					]
					drag: func [scroller offset /track /local parent save-x decal x][
						f: scroller/parent-face
						f/delay: 3  ;** don't perturb the scroll please
						if track [return scroller]
						if f/x <= abs offset/x [
							offset/x: to integer! offset/x + 4 / f/x * f/x
							save-x: f/xy/x
							x: f/xy/x: min 0 max 
								f/size/x - scroller/max-x
								f/xy/x - offset/x
							
							;** change change skip tail boxline -2 
							;**		as-pair negate x 1 as-pair 32 - x 18
							
							if 0 <> decal: x - save-x [move-x f decal]
							show f
						]
					]
					engage: func [f a e][false] ;** don't send events to the area
				]
			]
			cursor: make face [
				offset: 0x5 size: 2x18 para: color: edge: none
				xy: as-pair origine-x 5
				; len et old len ont été renomé en col et old-col apparement ... dans les version suivante
				sub-string: idx: global-idx: col: old-col: len: old-len:  
				old-idx: tmp-offset: pos-len: old-pos-len: none
				selection?: false
				selector-xy: [0x0]
				head?: false
				data: pos-blk: []
				blink-color: red
				size-box: 2x16
				effect: [draw [pen blink-color fill-pen blink-color box 0x1 size-box]]
				feel: make feel [
					redraw: func [f a][
						if a = 'show [
							f/offset: f/xy
							if f/selection? [
								f/selector-xy/1/x: f/xy/x - f/parent-face/xy/x
							]
						]
					]
					engage: func [f a e][] ;** disable events
				]
			]
			feel: make feel [
				scrollwheel: func [f event offset] [
					f/delay: 3
					dir: either event/offset/y > 0 ['down]['up]
					switch dir [
						down [render-text f 3] 
						up [render-text f -3]
					]
					if f/cursor/selection? [expand-selector f/cursor show f]
				]
				resize: func [f size+][
					f/size: f/size + size+
					f/nb-lines: to-integer (f/size/y - 10 / f/y)
					f/v-scroller/offset: as-pair f/size/x - 13 2
					f/h-scroller/offset: as-pair 2 f/size/y - 13
					render-text/stay f 1
					if f/cursor/selection? [expand-selector f/cursor show f]
				]
				
				begin-selection: func [
				cursor /local f
				][
	
					f: cursor/parent-face
					cursor/selection?: true
					insert-selector f next cursor/data/1 cursor/xy/x + f/xy/x
					cursor/selector-xy: back tail cursor/data/1/2
					cursor/old-idx: cursor/global-idx
					cursor/old-pos-len: cursor/pos-len
					get-col cursor
					cursor/old-col: cursor/col
				]
					
				drag: func [f offset /track /local cursor][	;** drag = selection
						;** beware, it's the cursor which moves, not the area.
				if track [return f/cursor]
				unless f/cursor/selection? [begin-selection f/cursor]

				;** not enough displacement to move the cursor
				if all [f/x > abs offset/x  f/y > abs offset/y][exit]

				case [
					all [positive? offset/y f/cursor/idx = f/nb-lines][render-text f 1]	;** scroll down
					all [negative? offset/y f/cursor/idx = 1][render-text f -1]	;** scroll up
				]
				click f f/cursor/xy + offset
				expand-selector f/cursor
				show f
				]				
				save-x: 0
				detect: func [f e][
					;**print remold [e/1 e/2 e/3 e/4 e/5 e/6]
					if e/type = 'move [
						;** because of the timer, 'move events are received, even if there is no move
						if all [find [info-position recycle] f/ask f/move-offset <> e/offset][
							f/ask: 'info-position 
							f/delay: 2
							f/move-offset: e/offset
						]
						return false
					]
					e
				]
				engage: func [f a e /local key tmp cursor select?][
					;**print remold [a e/type e/key e/1 e/2 e/3 e/4 e/5 e/6]
					if a = 'time [
							;print [now/time f/ask f/delay]
							either find [recycle info-position] f/ask [
								f/cursor/blink-color: get first reverse [red none]	
								show f/cursor
							][f/cursor/blink-color: red]
							case [
								0 > f/delay: f/delay - 1  [
									;** if f/ask <> 'show [print ["timer:" now/time f/ask] ]
									switch f/ask [
										show		[]
										recycle	[recycle]
									]
									f/ask: 'recycle
									f/rate: 1	;** default rate, 1 event per second
									f/delay: 5	;** recycle after 5 secs of inactivity
									show f		;** DON't remove the show here (needed to update the face rate)
								]
							]
							return false
					]
					cursor: f/cursor
					select?: cursor/selection?
					
					if f/ask <> 'show [f/ask: 'info-cursor  f/delay: 3]
					cursor/blink-color: red 
					unless find [up down] key: e/key [save-x: 0]
					if all [e/5 not select? any [ word? key key < #" "  ] ; "]  <- This is for the my editor tha mess " char
						][
						select?: true
						begin-selection cursor
					]
					
					switch a [
						down [click f e/offset]
						key [
							;probe key
							;** e/6 = true for ctrl
							switch/default key[
								page-up [render-text f negate f/nb-lines ]
								page-down [render-text f f/nb-lines ]
								#"^P" [inc-font-size f 1 ]  ;** increase font size
								#"^L" [inc-font-size f -1 ] ;** decrease font size
								#"^B" [bold f]
							][
								locate-cursor cursor
							]
							switch/default key [
								#"^M" [split-line f]
								#"^[" [] 
								#"^~" [ ;** delete
									either select? [
										do-selection/delete f
									][
										delete-char cursor
										recolorize cursor
										show f
									]
								]   
								#"^H" [ ;** backtab
									either select? [
										do-selection/delete f
									][
										move-cursor/left cursor
										delete-char cursor
										recolorize cursor
										show f
									]
								]   
								right [
									either e/6 [
										right-word cursor
									][
										move-cursor/right cursor
									]
									show cursor								]
								left [
									either e/6 [
										left-word cursor
									][
										move-cursor/left cursor
									]
									show cursor
								]
								;page-up [render-text f negate f/nb-lines]
								;page-down [render-text f f/nb-lines]
								down [down-cursor cursor]
								up [up-cursor cursor]
								end [
									constraint f as-pair 100000 cursor/xy/y
									show cursor
								]
								home [
									constraint f as-pair f/origine-x + f/xy/x cursor/xy/y
									show cursor
								]
								#"^S" [ 
										either e/shift [
											;Save as 
											file-name: request-file
											if not none? file-name [file-name: first file-name]
											if file-name [f/save-file]
											][  
											;SAVE
										if request "Save file ? " [ f/save-file] 
										]
									]
								#"^O" [ if request "Open a file?" [ f/open-file none]]
								#"^N" [ if request "Start a new file?" [f/data: build-data "" f  render-text/stay f 1 ]]
								;#"^P" [inc-font-size f 1]  ;** increase font size
								;#"^L" [inc-font-size f -1] ;** decrease font size
								f1 [t/run_scr] ;run script in editor
								f3 [  either e/shift [
									if 0 < length? s-text [ t/search-prev s-text ]
									][
										if 0 < length? s-text [ t/search-next s-text ]
										]
									]
								#"^-" [
									insert-char f/cursor "   "  
									recolorize f/cursor					
									show f
									]
								#"^C" [do-selection/clip f]
								#"^X" [do-selection/clip/delete f]
								
								#"^V" [
									tmp: read clipboard:// 
									write %temp.txt tmp
									tmp: read/lines %temp.txt
									foreach item tmp [
										insert-char f/cursor item 
										recolorize f/cursor
										split-line f								
										]								
									show f
									]
								#"^F" [ view/new  search-win ] ;[t/search f]
								#"^G" [ view/new goto-win ]
							][ 
								if all [char? key find key-to-insert key ][
									if select? [
										do-selection/delete f
									]
									;** insert a char
									locate-cursor f/cursor
									insert-char f/cursor e/key
									recolorize f/cursor
									;** auto-scroll horizontaly
									if f/x * 10 + cursor/xy/x > f/size/x [
										scroll-x f f/x * 10
										]
									show f
								]
							]
						]
					] 
					if select? [
						either any [e/5 e/6 a = 'up] [
							expand-selector cursor
						][
							remove-selector cursor
						]
						show f
				]
				]
				
				bold: func [f][
					f/font-obj/style: either f/font-obj/style [none]['bold]
					inc-font-size f 0
				]
				
				split-line: func [f /local tmp str blanks][
					insert-char f/cursor "^/" ;insert newline char

					tmp: at f/data f/cursor/idx
					str: tmp/1/2

					blanks: copy/part str find str any-char
					insert str: find/tail str newline blanks
					insert/only next tmp reduce [0 str 0x0]
					
					render-text/stay f f/cursor/idx
					replace/all blanks tab "    "
					f/cursor/xy/x: f/origine-x + f/xy/x + (f/x * length? blanks)
					down-cursor f/cursor
					save-x: 0
				]
				
				inc-font-size: func [f inc /local tmp][
					f/font-obj/size: max 10 min 30 f/font-obj/size  + inc
					f/origine-x: f/origine-x / f/x
					f/xy/x: f/xy/x / f/x
				;this is didec way used to compute the X size of a char on screen
				 	fa: make face [ font: f/font-obj text: "MM" 
				 		size: 100x100 para: make face/para [origin: 0x0 margin: 0x0] 
				 		edge: make face/edge [size: 0x0]]
				 	tx-test: fa/text
				 	forall tx-test [
						tmp: caret-to-offset fa tx-test  
				 		;probe tmp 
					]
					; we use size-tex for Y size of a char on screen 
					tmp2: size-text fa
					;probe tmp2
					tmp/y: tmp2/y
					;f/x: round  to integer! tmp/x / 2 
					f/x:  to integer! tmp/x
					f/y: tmp/y + 4  ; make the margin more spaced and easier to read
					f/xy/x: f/xy/x * f/x
					f/origine-x: f/origine-x * f/x
					f/cursor/size/y: f/y
					f/cursor/size-box/y: f/y - 2 
					tmp: f/cursor/xy
					resize f 0 
					click f tmp
				]
								
				do-selection: func [
						f
						/delete /clip
						/local cursor data idx old-idx start end str start-col end-col scroll n y
					][
						cursor: f/cursor
						if clip [clip: make string! 256]
						idx: cursor/global-idx
						old-idx: cursor/old-idx
						get-col cursor
						either old-idx < idx [
							set [start end] reduce [old-idx idx]
							set [start-col end-col] reduce [cursor/old-col  cursor/col]
							either start < index? f/data [
								scroll: start - index? f/data 
								n: -1 + min start to-integer f/nb-lines / 2
								scroll: scroll - n
								y: n * f/y + 2
							][
								y: cursor/xy/y +(start - end * f/y)
							]
						][
							set [start end] reduce [idx old-idx]
							set [start-col end-col] reduce [cursor/col  cursor/old-col]
						]
						data: at head f/data start
						if start = end [
							set [start-col end-col] sort reduce [start-col end-col]
						]
						if delete [
							locate-cursor cursor
							delete: copy/part data/1/2 start-col - 1
						]
						loop end - start [
							if clip [
								append clip append copy/part at data/1/2 start-col 
									any [find data/1/2 newline tail data/1/2]
									newline
		
							]
							either delete [remove data][data: next data]
							start-col: 1
						]
		
						str: data/1/2
						case/all [
							clip [
								append clip copy/part at str start-col at str end-col
								write clipboard:// clip
								clip: none
							]
							delete [
								data/1/2: delete
								case [
									scroll [render-text f scroll]
									start <> end [render-text/stay f 1]
									'else [recolorize cursor]
								]
								if y [cursor/xy/y: y]
								constraint f cursor/xy 
								append delete copy/part at str end-col any [find str newline tail str]
								recolorize cursor
							]
						]
					]
					
					

				
				click: func [f offset][
						;** We don't use the focus function to avoid this dummy system caret (whe have our own)
						unless same? system/view/focal-face f [
							if system/view/focal-face [unfocus]
							system/view/focal-face: f
						]
					
					constraint f either offset/x - f/xy/x < f/origine-x 
						[as-pair f/origine-x offset/y][offset]
					show f/cursor
				]
				expand-selector: func [
					cursor
				/local idx f pos curr-idx add-selector del-selector upd-selector str
					x upd-tail upd-head add-tail add-head calc-tail add-middle upd-middle old-idx
			][

				f: cursor/parent-face
				idx: cursor/global-idx
				old-idx: cursor/old-idx
				curr-idx: index? f/data
				del-selector: [change pos none]
				calc-tail: [
					x: 0
					parse pos [some [
						thru 'text skip pair! [set str string! | set str word! (str: get str)]
						(x: x + length? str)
					]]
					x: x + 1 * f/x
				]
				upd-middle: [cursor/selector-xy: back tail pos/1]
				upd-tail: [do calc-tail change back tail pos/1 as-pair x f/y + 7]
				upd-head: [change back tail pos/1 as-pair f/origine-x f/y + 7]
				add-head: [insert-selector f pos f/origine-x]
				add-tail: [do calc-tail insert-selector f pos x]
				add-middle: [print "Beginning of the selection lost, TO DO !!!"]

				upd-selector: [(
					either old-idx < idx [
						case [
							curr-idx < old-idx  del-selector
							curr-idx > idx	del-selector
							curr-idx = idx	upd-middle		;** cover until the position of the cursor
							'else			upd-tail		;** cover the tail of the line
						]
					][
						case [
							curr-idx < idx	del-selector
							curr-idx > old-idx  del-selector
							curr-idx = idx	upd-middle		;** cover until the position of the cursor
							'else			upd-head		;** cover the head of the line
						]
					]
					curr-idx: curr-idx + 1
				)]

				add-selector: [(
					either old-idx < idx [
						case [
							curr-idx < old-idx  none
							curr-idx > idx	none
							curr-idx = idx	[do add-head do upd-middle]		;** cover tail
							curr-idx = old-idx  [do add-middle 'do upd-tail];** cover middle to tail
							'else			[do add-head do upd-tail]		;** cover the whole line
						]
					][
						case [
							curr-idx < idx	none
							curr-idx > old-idx  none
							curr-idx = idx	[do add-tail do upd-middle]		;** cover tail
							curr-idx = old-idx  [do add-middle 'do upd-head];** cover middle to head
							'else			[do add-tail do upd-head]		;** cover the whole line
						]
					]
					curr-idx: curr-idx + 1
				)]

				parse f/effect/draw [
					any [
						thru 'push into ['hilight pos: [block! upd-selector | add-selector ] to end]
					]
				]
			]
				insert-selector: func [f where x][	;** append an highlight box in the current block at relative x position
					change/only where
						compose [pen 255.200.10 fill-pen 250.200.10 box (as-pair x 7) (as-pair x f/y + 7)]
				]
				remove-selector: func [cursor /local f tmp][
					cursor/selection?: false
					parse cursor/parent-face/effect/draw [
						any [thru 'push into ['hilight tmp: (change tmp none) to end]]
					]
				]
				left-word: func [cursor /local f x str blk pos s-blk][
					f: cursor/parent-face
					str: get-sub-string cursor
					blk: skip s-blk: cursor/pos-blk -2
					
					case [
						find/reverse blk 'edit				none 	;** not head of line
						not head? str						none	;** neither
						'else [
							cursor/xy/x: 100000
							if up-cursor cursor [left-word cursor]
							exit
						]
					]
					x: 0
					foreach stuff reduce [any-char space][
						while [
							all [
								not find/reverse str stuff
								blk
								blk: find/reverse blk 'edit
							]
						][
								x: x - 1 + index? str
								str: tail get* blk/3
						]
						x: x - length? str
						str: any [find/reverse str stuff str]
						x: x + length? str 
					]
					either str/1 = #" " [x: x - 1][x: x + (index? str) - index? head str]
					if x = 0 [x: -1 + index? str]
					constraint f cursor/xy + as-pair x * negate f/x 0
				]
				
				get-sub-string: func [cursor][
					at head do back change [none] cursor/sub-string cursor/pos-len	
				]
				
				right-word: func [cursor /local x str blk pos][
					f: cursor/parent-face
					blk: s-blk: cursor/pos-blk
					str: get-sub-string cursor
					
					case [
						find blk 'edit			none 	;** not tail of line
						not tail? str			none	;** neither
						'else [
							cursor/xy/x: f/origine-x + f/xy/x
							if down-cursor cursor [right-word cursor]
							exit
						]
					]
					x: 0
					foreach stuff reduce [space any-char][
						while [
							all [
								not find str stuff
								blk
								blk: find/tail blk 'edit
							]
						][
								x: x + length? str
								str: get* blk/2
						]
						x: x - index? str
						str: any [find str stuff str]
						x: x + index? str
					]
					if str/1 = #" " [x: x + length? str]
					if x = 0 [x: length? str] 
					constraint f cursor/xy + as-pair x * f/x 0
				]				
				
				scroll-x: func [f x][
					f/h-scroller/feel/drag f/h-scroller as-pair x 0
				]

				locate-cursor: func [cursor /local x idx f][
					f: cursor/parent-face
					unless cursor/show? [
						either (idx: cursor/global-idx) < index? f/data [
							render-text f idx - index? f/data
						][
							render-text f idx - f/nb-lines + 1 - index? f/data 
						]
					]
					x: cursor/xy/x
					if any [
						x > (f/size/x - f/x)
						x < f/x
					][scroll-x f f/x * 20 + f/xy/x + cursor/xy/x - f/size/x ]
				]
				

				move-cursor: func [
					cursor 
					/left /right
					/local f pos offset len
				][
					f: cursor/parent-face
					locate-cursor cursor
					;** print remold [cursor/pos-len cursor/sub-string]
					case [
						left [
							if len: either string? cursor/sub-string [
								either cursor/pos-len = 1 [1][
									cursor/pos-len: cursor/pos-len - 1
									cursor/sub-string: back cursor/sub-string 
									cursor/xy/x: cursor/xy/x - f/x 
									false
								]
							][
								either cursor/pos-len = 1 [1][
									cursor/pos-len: 1
									cursor/xy/x: cursor/xy/x - (f/x * length? get cursor/sub-string)
									false
								]
							][
								either pos: find/tail/reverse skip cursor/pos-blk -2 'edit [
									either string? pos/2 [
										len: length? pos/2
										cursor/sub-string: at pos/2 len 
									][
										cursor/sub-string: pos/2
									]
									cursor/pos-len: len 
									cursor/xy/x: pos/1/1 + (len - 1 * f/x)
									cursor/pos-blk: skip pos 1
								][
									if cursor/global-idx > 1 [
										cursor/xy/x: 100000
										up-cursor cursor 
									]								
								]
							]
						]
						right [
							if len: either string? cursor/sub-string [
								either tail? cursor/sub-string [2][
									cursor/pos-len: cursor/pos-len + 1
									cursor/sub-string: next cursor/sub-string 
									cursor/xy/x: cursor/xy/x + f/x 
									false
								]
							][
								either cursor/pos-len > 1 [2][
									cursor/pos-len: index? tail get cursor/sub-string 
									cursor/xy/x: cursor/xy/x + (f/x * length? get cursor/sub-string)
									false
								]
							][
								either pos: find/tail cursor/pos-blk 'edit [
									either string? pos/2 [
										cursor/sub-string: at pos/2 len 
									][
										len: index? tail get pos/2
										cursor/sub-string: pos/2
									]
									cursor/pos-len: len 
									cursor/xy/x: pos/1/1 + (len - 1 * f/x)
									cursor/pos-blk: skip pos 1
								][
									if cursor/global-idx < index? back tail f/data [
										cursor/xy/x: f/origine-x + f/xy/x
										down-cursor cursor
									]
								]
							]
						]
					]
				]
				delay-show: func [f][
					f/ask: 'show		;** delay the show event, speed issue
					f/delay: 1		;   wait 2 checks
					f/rate: 10		;   check 10 times per second
				]
				down-cursor: func [cursor /local p tmp][
					p: cursor/parent-face
					if cursor/global-idx < index? back tail p/data [
						if cursor/idx = p/nb-lines [
							delay-show p
							render-text p 1
						]
						tmp: cursor/xy + third cursor/data 
						if save-x = 0 [save-x: tmp/x]
						constraint p as-pair save-x tmp/y
						unless p/ask = 'show [show cursor]
						true
					]
				]
				up-cursor: func [cursor /local p tmp][
					p: cursor/parent-face
					if cursor/global-idx > 1 [
						if cursor/idx = 1 [
							delay-show p
							render-text p -1
						]
						tmp: cursor/xy - pick cursor/data -2
						if save-x = 0 [save-x: tmp/x]
						constraint p as-pair save-x tmp/y
						unless p/ask = 'show [show cursor]
						true
					]
				]				

				insert-char: func [cursor char /local f text refresh?][
					f: cursor/parent-face
					if cursor/selection? [
						do-selection/delete f
						locate-cursor cursor
						refresh?: true
					]
					text: cursor/sub-string
					either string? text [
						insert text char
					][
						insert insert
							either cursor/pos-len = 1 [cursor/pos-blk][next cursor/pos-blk]
							'new
							char
					]
					collect cursor
					cursor/xy/x: cursor/xy/x + either char = tab [4 * f/x][f/x * length? form char]
						
					if refresh? [
						render-text/stay f 1
						constraint f cursor/xy
					]				
				]

				
				delete-char: func [cursor /local pos f data str1 str2 end][
					text: cursor/sub-string 
					unless either string? text [
						unless tail? text [remove text]
					][
						if cursor/pos-len = 1 [remove back cursor/pos-blk] ;**remove the offset
					][
						either pos: find/tail cursor/pos-blk 'edit [
							either string? pos/2 [
								remove pos/2
							][
								remove pos	;** remove the offset
							]
						][
						   regroup-2-lines cursor
						   exit
						]
					]
					
					collect cursor
				]
							get-col: func [cursor /local col pos][
				col: 0
				pos: cursor/data/1 
				while [pos: find/tail pos 'edit][
					if same? pos: next pos cursor/pos-blk [break]
					col: col + either string? pos/1 [length? head pos/1][1]
				]
				col: col + either string? cursor/sub-string 
					[cursor/pos-len]
					[either cursor/pos-len > 1 [2][1]]
				cursor/col: col
			]
				collect: func [cursor /local full txt pos len][
					full: clear {}
					len: 0
					add-full: [(
						len: len + either char? txt [1][length? get* txt]
						full: insert full either word? txt [#"^-"][txt]
					)]
					parse cursor/data/1 [
						any [thru 'edit opt [
								pair! 
								opt ['new set txt skip add-full]
								set txt skip add-full
								opt ['new set txt skip add-full]
						]]
					]
					cursor/old-len: len
					poke first at cursor/parent-face/data cursor/idx 2 copy head full
				]
				regroup-2-lines: func [cursor][
					f: cursor/parent-face
					data: at head f/data cursor/global-idx
					unless tail? next data [
						str1: either end: find data/1/2 newline [copy/part data/1/2 end][data/1/2]
						str2: either end: find data/2/2 newline [copy/part data/2/2 end][data/2/2]
						append str1 str2
						poke data/1 2 str1
						remove next data
						render-text/stay f cursor/idx
					]
				]
				
				;*** Reconstruct a line (draw block) after an insert
				;*** (which contains modified sub-strings)
				;* if the line contains a multi-line string, then other lines below
				;* may be reconstructed too.
				recolorize: func [
					cursor 
					/local line f multi-p multi data pos-head
				][
					f: cursor/parent-face
					data: cursor/data
					line: at f/data cursor/idx

					change skip data 2 
						either colorize f line clear find/tail data/1 string! 
						[as-pair 0 2 * f/y][as-pair 0 f/y]
					
					;** move the cursor, after insertion
					;**cursor/xy/x: cursor/xy/x + probe (cursor/len - cursor/old-len * f/x) 
						
					loop f/nb-lines - cursor/idx [
						if tail? next line [break] 
						
						multi-p: line/1/1
						multi: line/2/1
						if any [
							all [find [1 2] multi-p find [1 3] multi]
							all [find [3 4] multi-p find [2 4] multi]
						][break]
					
						data: find/tail data 'push
						line: next line
						change skip data 2 
							either colorize f line clear find/tail data/1 string! 
							[as-pair 0 2 * f/y][as-pair 0 f/y]
					]
					constraint f cursor/xy
					set-y f 5
				]

				constraint: func [
					f offset 
					/local cursor y blk pair text cont stop idx save-pair
				][
					y: idx: 0
					cont: none
					stop: [cont: 'break]
					cursor: f/cursor
					parse f/effect/draw [
						some [
							thru 'push blk: block! skip set pair pair! 
							(idx: idx + 1 if offset/y <= (y + pair/y) stop) cont (y: y + pair/y)
						] 
						:blk into [
							(cont: none)
							thru 'edit set pair pair! pos-head: text: skip
							any [
								thru 'edit set save-pair pair! 
								(if offset/x < save-pair/x stop) cont 
								text: skip (pair: save-pair)
							]
						]
					]
					either string? text/1 [
						offset: min length? text/1 to integer! offset/x - pair/x / f/x
						cursor/xy: as-pair
							offset * f/x + pair/x
							y + 7
						cursor/sub-string: skip text/1 offset
						cursor/pos-len: offset + 1
					][
						;** special case, for tabulation
						cursor/xy: as-pair pair/x y + 7
						cursor/sub-string: text/1
						cursor/pos-len: either find text 'edit [1][index? tail get text/1]
					]
					cursor/head?: pos-head
					cursor/data: blk
					cursor/pos-blk: text
					cursor/idx: idx
					cursor/global-idx: idx - 1 + index? f/data

					case [
						cursor/xy/x < 0 [scroll-x f -20 * f/x + cursor/xy/x]
						cursor/xy/x > f/size/x [scroll-x f f/x * 20 + f/xy/x + cursor/xy/x - f/size/x]
					]
				]
			]; fin feel 
			append init [
				data: append/only make block! 1000 reduce [0 ""]
				v-scroller: make v-scroller [] 
				h-scroller: make h-scroller [] 
				cursor: make cursor []
				pane: reduce [cursor v-scroller h-scroller]
				edge: make edge []
				data: build-data "" self
				feel/resize self first reduce [size size: 0]
			]
			export: context [
				font+: func [f][f/feel/inc-font-size f +1]
				font-: func [f][f/feel/inc-font-size f -1]
				bold: func [f][f/feel/bold f]
			]
		]; fin feel:
] ;** end of global context


; API layouts

pref_win: layout [
	across
	;text "Rebol VM path:"
	;return
	;fi: field 300 pref/consol_path btn "..." [ if none? (fi/text: request-file/title/filter "Choose REBOL VM" "Select" "*.exe" ) [ fi/text: pref/consol_path ] show fi]
	return
	text "API Colors" 
	return
	text "Background color:" b1: box 20x20 pref/bg_color btn "..." [ if none? b1/color: request-color [b1/color: white ] show b1 ] 
	return
	text "Default text color:" b2: box 20x20 pref/txt_color btn "..." [ if none? b2/color: request-color [ b2/color: black ] show b2]
	return tab 
	btn "Ok" [ sav-pref  t/color: pref/bg_color unview/only pref_win render-text/stay t 1 show t]
	btn "Cancel" [ unview/only pref_win ]
]

search-win: layout [
	across 
    label "Find what:" 
    fi-s: field [ 
	if 0 < length? fi-s/text [ s-text: fi-s/text t/search-next s-text ] 
	unview/only search-win 
	]
    return
    pad 150
    btn-enter  [ 
	if 0 < length? fi-s/text [ s-text: fi-s/text t/search-next s-text ] 
	unview/only search-win 
	]
    btn-cancel  [ unview/only search-win ]
]
s-text: ""

goto-win: layout [
	across 
	text "Enter line number:" return
	f-goto: field 100 return
	tab btn "OK" [ i-goto: to integer! f-goto/text if i-goto < length? t/data [ t/goto-line i-goto ] unview/only goto-win ]
    btn "Cancel" [ unview/only goto-win ]
]




;***************
;***************
;Special function

;Return the usage of every command
utilizzo:  func [
    "Prints information about words and values."
    'word [any-type!]
    /local value args item type-name refmode types attrs rtype temp4
][
temp4: copy []
if all [word? :word not value? :word] [word: mold :word]
    if any [string? :word all [word? :word datatype? get :word]] [
        types: dump-obj/match system/words :word
        sort types
        if not empty? types [
            return reform ["Found these words:" newline types]
            exit
        ]
        return reform ["No information on" word "(word has no value)"]
        exit
    ]
    type-name: func [value] [
        value: mold type? :value
        clear back tail value
        join either find "aeiou" first value ["an "] ["a "] value
    ]
    if not any [word? :word path? :word] [
        return reform [mold :word "is" type-name :word]
        exit
    ]
    value: either path? :word [first reduce reduce [word]] [get :word]
    if not any-function? :value [
        append temp4 [uppercase mold word "is" type-name :value "of value: "]
        append temp4 either object? value [print "" dump-obj value] [mold :value]
         return reform temp4
        exit
    ]
    args: third :value
    
    append temp4  "USAGE: "
    if not op? :value [append temp4 (append uppercase mold word " ")]
    while [not tail? args] [
        item: first args
        if :item = /local [break]
        if any [all [any-word? :item not set-word? :item] refinement? :item] [
            append temp4 (append mold :item " ")
            if op? :value [append temp4 (append uppercase mold word " " value: none)]
        ]
        args: next args
    ]
    return reform temp4
    ]


;insert text in main area
inni: func [testo2 /local tmp] [
	tmp: testo2
	write %temp.txt tmp
	tmp: read/lines %temp.txt	
	foreach item tmp [
		t/feel/insert-char t/cursor item 
		t/feel/recolorize t/cursor		
		]								
		show t
	temp3: parse testo2 none	
	temp3: to-word first temp3
	temp3: utilizzo :temp3	
	uso/text: to-string temp3
	show uso	
	]



;all rebol conversion functions
allconversions:  [to-binary 
    to-bitset to-block to-char to-closure to-datatype to-date to-decimal to-email to-error to-file to-function to-get-path to-get-word to-hash 
    to-hex to-idate to-image to-integer to-issue to-itime to-library to-list to-lit-path to-lit-word to-local-file to-logic to-map 
    to-money to-none to-pair to-paren to-path to-port to-rebol-file 
    to-refinement to-relative-file to-set-path to-set-word to-string to-tag to-time to-tuple to-typeset to-url to-word
]




;*******************
;Let's start
unview/all

IDE:	 layout  [
		across space 0x0 origin 0x0
		mn: menu  with [ 
			size: 935x20 data: compose/deep [
				"File" [
					"New"  # "Ctrl+N" [if request "Start a new file?" [t/new-file]]
					"Open" # "Ctrl+O" [t/open-file none ]					
					bar
					"Save" # "Ctrl+S" [ if all [  request "Save file ? "] [ t/save-file]]
					"Save as..." # "SHIFT+CTRL+S" [ 
						file-name: first request-file
						if file-name [f/save-file]
						]
					bar
					"Exit" [quit]
				]
				"Search" [
					"Find..." # "CTRL+F" [ view/new  search-win ] 
					bar
					"Find Next" # "F3" [ if 0 < length? s-text [ t/search-next s-text ]]
					"Find Prev" # "SHIFT+F3" [ if 0 < length? s-text [ t/search-prev s-text ]]
					bar 
					"Go to ..." # "CTRL+G" [ view/new goto-win ]
				]
				
				"View" [
					"Text Size" sub [
						"Text +" [t/export/font+ t]
						"Text -" [t/export/font- t]
					]
					"BOLD/NORMAL" [t/export/bold t]
					
				]
				"Script" [
					"Run" # "F1" [ if request "Run this Script ?" [ t/run_scr ] ]
				]
 				 "Tools" [
				 	"Preferencies" [ view/new pref_win ]
				]
				"Guides" [
					"Core" [ view/new/options coremanual_main 'resize]
					"VID" [ 
						if not exists? %nyc.jpg [
							attempt [
								temp: read/binary http://www.rebol.com/view/nyc.jpg
								write/binary %nyc.jpg temp
								]
							]	
						view/new/options  guida_vid 'resize
						]
					"VID events" [ view/new/options  guida_handler 'resize]	
					"DRAW" [ view/new/options  guida_DRAW 'resize]
					"SHAPE" [ view/new/options   guida_shape  'resize] 
					]
				"Help" [					
					"About..." [view/new  aboutpage] 					
					]
			]
		] return
		;below across 
		return 
		uso: text resize-x 900 "USAGE:"  			
		return	
		
		tb: tab-panel  data [
			"Core"  [	
				
				core_sp: scroll-panel 325x432 [	;core_sp is a nice name for croll panale of core buttons
					style button btn white
					style group-box panel 255.255.255 frame black 2x2
					; origin 0x0
					button pink "Example" [ inni {Rebol [] 
 print "Hello word!" 
 wait 10 } ] help "Example"
					
					group-box   [
						h2 "Comparison" 
						across
						button   "<" [ inni "< " ] help  "Returns TRUE if the first value is less than the second value"
						button  "<=" [ inni "<= " ] help  "Returns TRUE if the first value is less than or equal to the second value"
						button  "<>" [ inni "<> " ] help  "Returns TRUE if the values are not equal"
						button  "=" [ inni "= " ] help  "Returns TRUE if the values are equal"
						button  "==" [ inni "== " ]  help  "Returns TRUE if the values are equal and of the same datatype"
						return 
						button  "=?" [ inni "=? " ]  help  "Returns TRUE if the values are identical.(same memory)"
						button  ">" [ inni "> " ]  help  "Returns TRUE if the first value is greater than the second value"
						button  ">=" [ inni ">= " ]  help  "Returns TRUE if the first value is greater than or equal to the second value"
							button  "!=" [ inni "!= " ]  help  "Returns TRUE if the values are not equal"
						button  "!==" [ inni "!== " ]  help  "Returns TRUE if the values are not equal and not of the same datatype"
						return 
						button  "=?" [ inni "?= " ]  help  "Returns TRUE if the values are identical"
						]
						
					group-box  [
						h2 "Context"
						across 						
						button  "alias" [ inni "alias " ]  help "Creates an alternate alias for a word"
						button   "bind" [ inni "bind /copy " ]  help "Binds words to a specified context"
						button   "bind?" [ inni "bind?  " ]  help "Returns the context in which a word is bound?"
						button   "body-of" [ inni "body-of  " ]  help "Returns a copy of the body of a function or object"
						return 
						button   "bound?" [ inni "bound?  " ]  help "Returns the context in which a word is bound"						
						button   "closure" [ inni "closure [] []  " ]  help "Defines a closure function"
						button   "closure?" [ inni "closure? " ]  help "Returns TRUE if it is this type"
						return 
						button   "collect" [ inni "collect /into [] " ]  help "Evaluates a block, storing values via KEEP function, and returns block of collected values"
						return 
						button   "collect-words" [ inni "collect-words /deep /set /ignore [] " ]  help " Collect unique words used in a block (used for context construction)"
						button   "construct" [ inni "construct /with " ]  help "Creates an object, but without evaluating its specification"
						return 
						button   "context" [ inni "context " ]  help "Defines a unique (underived) object"
						button   "default" [ inni "default " ]  help "Set a word to a default value if it hasn't been set yet"
						button   "free" [ inni "free " ]  help " Frees a REBOL resource. (Command version only)"
						button   "get" [ inni "get /any " ]  help "Gets the value of a word"
						return
						button   "in" [ inni "in " ]  help "Returns the word in the object's context"
						return 
						button   "link-app?" [ inni "link-app? " ]  help " Tell whether a script is running under a Link application context"				
						button   "protect" [ inni "protect " ]  help "Protect a word or block to prevent from being modified"
						button   "protect-system" [ inni "protect-system " ]  help "Protects all system functions and the system object from redefinition"
						return 
						button   "reflect" [ inni "reflect" ]  help "Returns definition-related details about a value"				
						button   "resolve" [ inni "resolve /only /all " ]  help "Copy context by setting values in the target from those in the source."     
						button   "set" [ inni "set /any /pad " ]  help "Sets a word or block of words to specified value(s)"
						button   "unbind" [ inni "unbind  /deep" ]  help "Unbinds words from context"
						return 
						button   "unset?" [ inni "unset?  " ]  help "Returns TRUE for unset values"
						return 
						button   "unprotect" [ inni "unprotect " ]  help "Unprotects a word or block of words"
				 		button   "unset" [ inni "unset " ]  help "Unsets the value of a word"				
						button   "use" [ inni "use " ]  help "Defines words local to a block"
						button   "value?" [ inni "value? " ]  help "Returns TRUE if the word has been set"				
						]	
					
				group-box   [
				h2 "Control"
				across
				button   "also" [ inni "also [] []  " ]  help " Returns the first value, but also evaluates the second"
				button   "break" [ inni "break /return " ]  help "Breaks out of a loop, while, until, repeat, foreach, etc"
				button   "case" [ inni "case /all [] " ]  help " Evaluates each condition, and when true, evaluates what follows it."
				button   "catch" [ inni "catch [ throw ] " ]  help "Catches a THROW from a block and returns its value"
				return				
				button   "disarm" [ inni "disarm " ]  help "Returns the error value as an object"
				button   "do" [ inni "do /args /next [] " ]  help "Evaluates a block, file, URL, function, word, or any other value"
				button   "do-boot" [ inni "do-boot " ]  help "Does a value only if it and its file (URL) and it's dependent exists"
				return
				button   "do-browser" [ inni "do-browser " ]  help "Evaluate browser script"
				return 
				button   "do-events" [ inni "do-events " ]  help " Process all View events"
				button   "do-face" [ inni "do-face " ]  help "(undocumented)"
				button   "do-face-alt" [ inni "do-face-alt " ]  help "(undocumented)"
				return 
				button   "do-thru" [ inni "do-thru /args /update /check /boot " ]  help "Do a net file from the disk cache"
				button   "does" [ inni "does [] " ]  help "A shortcut to define a function that has no arguments or locals"
				button   "either" [ inni "either [] []  " ]  help "If condition is TRUE, evaluates the first block, else evaluates the second"
				button   "else" [ inni "else []  " ]  help "Else is obsolete; use either"
				return 
				button   "exists-thru?" [ inni "exists-thru? /check  " ]  help "Checks if a file is in the disk cache. Returns: none, false (out of date), or file"
				 button   "exit" [ inni "exit " ]  help "Exits a function, returning no value"
				button   "for" [ inni "for word start end bump [] " ]  help "Repeats a block over a range of values"
				button   "forall" [inni "forall " ] help "Evaluates a block for every value in a series"
				return 
				button   "foreach" [inni "foreach word series [] " ] help "Evaluates a block for each value(s) in a series"
				button   "forever" [ inni "forever [] " ]  help "Evaluates a block endlessly"
				button   "forskip" [ inni "forskip word skip-num series [] " ]  help "Evaluates a block for periodic values in a series"
				return
				button   "func" [ inni {func [ /local "usage" /refinemet "refinemet usage"] []} ]  help "Creates a function"
				button   "funct" [ inni {funct [spec body /with object]} ]  help "Defines a function with all set-words as locals"
				button   "function" [ inni {function [spec var body]} ]  help "Defines a user function with local words"
				button   "halt" [ inni "halt " ]  help "Stops evaluation and returns to the input prompt"
				return
				button   "has" [ inni "has " ]  help "A shortcut to define a function that has local variables but no arguments"				 
				button   "if" [ inni "if  cond [] " ]  help "If condition is TRUE, evaluates the block"
				return
				button   "in-dir" [ inni "in-dir " ]  help "Evaluate a block while in a directory"
				button   "launch" [ inni "launch " ]  help "Launches a new REBOL interpreter process"
				button   "launch-thru" [ inni "launch-thru /update /check " ]  help " Launch a net file from the disk cache"
				button   "loop" [ inni "loop n [] " ]  help "Evaluates a block a specified number of times"
				return 			
				button   "repeat" [ inni "repeat " ]  help "Evaluates a block a specified number of times"
				button   "quit" [ inni "quit " ]  help "Stops evaluation and exits the interpreter"
				button   "quote" [ inni "quote " ]  help "Returns the value passed to it without evaluation"
				button   "reduce" [ inni "reduce " ]  help "Evaluates an expression or block expressions and returns the result"
				return
				button   "rejoin" [ inni "rejoin " ]  help "Reduces and joins a block of values"
				button   "return" [ inni "return " ]  help "Returns a value from a function"
				button   "secure" [ inni "secure []  " ]  help "Specifies security policies (access levels and directories)"
				button   "switch" [ inni "switch /default [] " ]  help "Selects a choice and evaluates what follows it"
				return				
				button   "throw" [ inni "throw /name " ]  help "Throws control back to a previous catch"
							
				button   "until" [ inni "until []  " ]  help "Evaluates a block until its last command is TRUE"
				button   "unless" [ inni "unless  " ]  help "Evaluates the block if condition is not TRUE"
				return
				button   "wait" [ inni "wait /all " ]  help "Waits for a duration, port, or both"				
				button   "while" [ inni "while [] [] " ]  help "While the first block is TRUE, evaluates the second block"				
				]
				
				group-box   [
					h2 "Datatype"
					across
					button   " datatypes" [ inni " datatypes  " ]  help "Variable that contains all datatypes"
					return 
				group-box [
					h3 "Conversion"
					across
					button   "to" [ inni "to binary!/bitset!/block!/char!/date!/decimal!/email!/file!/get-word!/hash!/hex!/idate!/image!/integer!/issue!/list!/lit-path!/lit-word!/logic!/money!/pair!/paren!/path!/refinement!/set-path!/set-word!/string!/tag!/time!/tuple!/url!/word!" ]  help "Constructs and returns a new value after conversion"
					text "or"
					drop-down    data allconversions [ inni  face/text ]
					return 
					button   "as-pair" [ inni "as-pair  " ]  help "Combine X and Y values into a pair"
					button   "as-binary" [ inni "as-binary  " ]  help "Coerces any type of string into a binary! datatype without copying it"
					button   "as-string" [ inni "as-string  " ]  help "Coerces any type of string into a string! datatype without copying it"
					return 
					button   "cvs-date" [ inni "cvs-date  " ]  help "Converts CVS date"
					button   "cvs-version" [ inni "cvs-version  " ]  help "Converts CVS version number"
					]
					return 

				button   "action?" [ inni "action?  " ]  help "Returns TRUE for action values"
				return 				
				button   "ascii?" [ inni "ascii?  " ]  help " Returns TRUE if value or string is in ASCII character range (below 128)"
				button   "binary?" [ inni "binary? " ]  help "Returns TRUE for binary values"
				return
				button   "bitset?" [ inni "bitset?  " ]  help "Returns TRUE for bitset values"
				button   "block?" [ inni "block?  " ]  help " Returns TRUE for block values"
				button   "char?" [ inni "char?  " ]  help " Returns TRUE for char values"				
				button   "datatype?" [ inni "datatype?  " ]  help "Returns TRUE for datatype values"				
				return
				button   "date?" [ inni "date?  " ]  help "Returns TRUE for date values"
				button   "decimal?" [ inni "decimal? " ]  help "Returns TRUE for decimal values"
				button   "email?" [ inni "email?  " ]  help " Returns TRUE for email values"
				return
				button   "error?" [ inni "error?  " ]  help "Returns TRUE for error values"
				button   "function?" [ inni "function?  " ]  help "Returns TRUE for function values"
				button   "get-word?" [ inni "get-word?  " ]  help " Returns TRUE for get-word values"
				return 
				button   "get-path?" [ inni "get-path?  " ]  help " Returns TRUE for get-path values"
				return
				button   "hash?" [ inni "hash?  " ]  help "Returns TRUE for hash values"
				button   "image?" [ inni "image?  " ]  help "Returns TRUE for image values"
				button   "integer?" [ inni "integer?  " ]  help " Returns TRUE for integer values"
				button   "issue?" [ inni "issue?  " ]  help "Returns TRUE for issue values"
				return
				button   "library?" [ inni "library?  " ]  help "Returns TRUE for library values"
				button   "list?" [ inni "list?  " ]  help "Returns TRUE for list values"
				button   "lit-path?" [ inni "lit-path?  " ]  help " Returns TRUE for lit-path values"
				return
				button   "lit-word?" [ inni "lit-word?  " ]  help " Returns TRUE for lit-word values"
				button   "logic?" [ inni "logic?  " ]  help " Returns TRUE for logic values"
				button   "make" [ inni "make  " ]  help " Constructs and returns a new value"
				return
				button   "map?" [ inni "map?  " ]  help "Returns TRUE for hash values"
				button   "money?" [ inni "money?  " ]  help " Returns TRUE for money values"
				button   "native?" [ inni "native?  " ]  help "Returns TRUE for native values"
				return 
				button   "native" [ inni "native  " ]  help "(undocumented)"
				button   "none?" [ inni "none?  " ]   help "Returns TRUE for none values"
				return
				button   "number?" [ inni "number?  " ]  help "Returns TRUE for number values"
				button   "object?" [ inni "object?  " ]  help "Returns TRUE for object values"
				button   "op?" [ inni "op?  " ]  help " Returns TRUE for op values"
				return
				button   "pair?" [ inni "pair?  " ]  help " Returns TRUE for pair values"
				button   "paren?" [ inni "paren?  " ]  help " Returns TRUE for paren values"
				button   "path?" [ inni "path?  " ]  help "Returns TRUE for path values"
				button   "port?" [ inni "port?  " ]  help " Returns TRUE for port values"
				return
				button   "refinement?" [ inni "refinement?  " ]  help "Returns TRUE for refinement values"
				button   "routine?" [ inni "routine?  " ]   help "Returns TRUE for routine values"
				return
				button   "series?" [ inni "series?  " ]  help "Returns TRUE for series values"
				button   "set-path?" [ inni "set-path?  " ]  help "Returns TRUE for set-path values"
				button   "set-word?" [ inni "set-word?  " ]  help "Returns TRUE for set-word values"
				return
				button   "scalar?" [ inni "scalar?  " ]  help " Returns TRUE for scalar values"
				button   "string?" [ inni "string?  " ]  help " Returns TRUE for string values"
				button   "struct?" [ inni "struct? " ]  help "Returns TRUE for struct values"
				button   "tag?" [ inni "tag?  " ] help "Returns TRUE for tag values"
				return
				button   "time?" [ inni "as-pair  " ] help "Returns TRUE for time values"
				return 
				button   "tuple?" [ inni "tuple?  " ]  help "Returns TRUE for tuple values"
				button   "type?" [ inni "type?  " ]  help "Returns a value's datatype"
				button   "typeset?" [ inni "typeset?  " ]  help "Returns TRUE if it is this type"
				return
				button   "unset?" [ inni "unset?  " ]  help "Returns TRUE for unset values"
				button   "url?" [ inni "url?  " ]  help " Returns TRUE for url values"
				button   "utf?" [ inni "utf?  " ]  help "Returns the UTF encoding from the BOM (byte order marker): + for BE; - for LE"
				button   "word?" [ inni "word?  " ]  help " Returns TRUE for word values"
				]
				
			group-box  [
				h2 "Debug" 
				across
				button   "asert" [ inni "assert [] " ]  help "Assert that condition is true, else throw an assertion error"
				button   "attempt" [ inni "attempt [] " ]  help "Tries to evaluate and returns result or NONE on error"
				button   "cause-error" [ inni "cause-error  err-type err-id args " ]  help "Causes an immediate error with the provided information"
				return 
				button   "comment" [ inni "comment []  " ]  help "Ignores the argument value and returns nothing"
				button   "component?" [ inni "component?  " ]  help "Returns specific REBOL component info if enabled"
				button   "dump-obj" [ inni "dump-obj /match " ]  help "Returns a block of information about an object"				
				return 
				button   "dbug" [ inni "dbug " ]  help "(Undocumented)"
				button   "probe" [ inni "probe " ]  help "Prints a molded, unevaluated value and returns the same value"
				return 
				button   "source" [ inni "source " ]  help "Prints the source code for a word"
				button   "stats" [ inni "stats /pools /types /series /frames /recycle /evals /clear " ]  help "System statistics.  Default is to return total memory used"
				button   "trace" [ inni "trace /net /function " ]  help "Enables and disables evaluation tracing"
				button   "throw-error" [ inni "throw-error " ]  help "Causes an immediate error throw with the provided information"
				return 
				button   "throw-on-error" [ inni "throw-on-error " ]  help "Evaluates a block, which if it results in an error, throws that error"
				button   "title-of" [ inni "title-of " ]  help "Returns a copy of the title of a function"
				button   "try" [ inni "try [] " ]  help "Tries to DO a block and returns its value or an error"
				return 
				button   "types-of" [ inni "types-of " ]  help "Returns a copy of the types of a function"
				button   "values-of" [ inni "values-of " ]  help "Returns a copy of the values of an object"
				button   "vbug" [ inni "vbug " ]  help "(undocumented)"
				button   "?" [ inni "? " ]  help "Prints information about words and values"
				return
				button   "??" [ inni "?? " ]  help "Prints a variable name followed by its molded value"
				return
				button   "about" [ inni "about " ]  help "Information about REBOL"
				button   "what" [ inni "what " ]  help "Prints a list of globally-defined functions"
				button   "words-of" [ inni "words-of " ]  help "Returns a copy of the words of a function or object"
				]
			group-box   [
				h2 "Email" 
				across
				button   "build-attach-body" [ inni "build-attach-body  BODY FILES BOUNDARY_STRING" ]  help "Return an email body with attached files"
				button   "build-markup" [ inni "build-markup /quite" ]  help "Return markup text replacing <%tags%> with their evaluated results"
				return 
				button   "build-tag" [ inni "build-tag " ]  help "Generates a tag from a composed block"
				button   "import-email" [ inni "import-email /multiple " ]  help "Constructs an email object from an email message"
				return 
				button   "parse-email-addrs" [ inni "parse-email-addrs " ]  help "Create a series from a string conaining multiple email adresses."
				button   "send" [ inni "send /only /header /attach /subject /show address message " ]  help "Send a message to an address(es)"
				button   "resend" [ inni "resend " ]  help "Relay a message"
				]
			group-box   [
				h2 "Encryption & Compression"
				across 
				button   "compress" [ inni "compress  " ]  help "Compresses a string series and returns it"
				button   "decompress" [ inni "decompress  " ]  help "Decompresses a binary series back to a string"
				return
				button   "shift" [ inni "shift /left /logical /part   " ]  help " Perform a bit shift operation. Right shift (decreasing) by default"
				return 
				button   "encloak" [ inni "encloak /with " ]  help "Scrambles a string or binary based on a key"
				button   "decloak" [ inni "decloak /with  " ]  help " Descrambles the string scrambled by encloak"
				return 
				button   "dh-compute-key" [ inni "dh-compute-key  " ]  help "Computes the resulting, negotiated key from a private/public key pair and the peer's public key"
				button   "dh-generate-key" [ inni "dh-generate-key  " ]  help "Generates a new DH private/public key pair"
				return 
				button   "dh-make-key" [ inni "dh-make-key  /generate " ]  help "Creates a key object for DH"
				return 
				button   "dsa-generate-key" [ inni "dsa-generate-key " ]  help "Generates a new private/public key pair"
				button   "dsa-make-key" [ inni "dsa-make-key /generate" ]  help "Creates a key object for DSA"
				return 
				button   "dsa-make-signature" [ inni "dsa-make-signature /sign " ]  help "Creates a DSA signature"
				return 
				button   "dsa-verify-signature" [ inni "dsa-verify-signature  " ]  help "Verifies if the DSA signature of a binary is correct"
				return 
				button   "rsa-encrypt" [ inni "rsa-encrypt /decrypt /private /padding  " ]  help "Encrypts or decrypts some data"
				button   "rsa-generate-key" [ inni "rsa-generate-key " ]  help "Creates a new private/public key pair"
				return 
				button   "rsa-make-key" [ inni "rsa-make-key " ]  help "Creates a key object for RSA"
				]
			group-box   [
				h2 "File & Directory"
				across
				button   "to-local-file" [ inni "to-local-file  " ]  help "Converts a REBOL file path to the local system file path"
				button   "to-rebol-file" [ inni "to-rebol-file  " ]  help "Converts a local system file path to a REBOL file path"
				return 
				button   "change-dir" [ inni "change-dir " ]  help "Changes the active directory path"				
				button   "cd" [ inni "cd " ]  help "Change directory (shell shortcut function)"
				button   "clean-path" [ inni "clean-path " ]  help "Cleans-up '.' and '..' in path; returns the cleaned path"
				return 
				button   "create-link" [ inni "create-link /start /note /args " ]  help "Creates file links"
			
				button   "delete" [ inni "delete " ]  help "Deletes the specified file(s) or empty directory(s)"
				button   "delete-dir" [ inni "delete-dir " ]  help "Deletes a directory including all files and subdirectories"
				return
				button   "dir?" [ inni "dir? " ]  help "Returns TRUE if a file or URL is a directory"
				button   "dirize" [ inni "dirize " ]  help "Returns a copy of the path turned into a directory"
				button   "echo" [ inni "echo %file  ^/  echo none " ]  help "Copies console output to a file"
				button   "exists?" [ inni "exists? " ]  help "Determines if a file or URL exists"
				return
				button   "file?" [ inni "file? " ]  help " Returns TRUE for file values"
				button   "info?" [ inni "info? " ]  help "The information is returned within an object that has SIZE, DATE, and TYPE words"
				button   "list-dir" [ inni "list-dir " ]  help "Prints a multi-column sorted listing of a directory"
				return 
				button   "link-relative-path" [ inni "link-relative-path " ]  help "Remove link-root from a file path"				
				button   "more" [ inni "more " ]  help "Print file (shell shortcut function)"
				button   "make-dir" [ inni "make-dir " ]  help "Creates the specified directory. No error if already exists"
				return
				button   "modified?" [ inni "modified? " ]  help "Returns the last modified date of a file or URL"
				button   "path-thru" [ inni "path-thru " ]  help "Return a path relative to the disk cache"
				button   "rm" [ inni "rm  /any " ]  help "Deletes the specified file(s)"
				button   "rename" [ inni "rename " ]  help "Renames a file to a new name"
				return 
				button   "pwd" [ inni "pwd " ]  help " Prints the active directory path"
				button   "save" [ inni "save /header /bmp /png /all " ]  help "Saves a value or a block to a file or url"
				
				button   "save-user" [ inni "save-user " ]  help " Save user.r, prompting for overwrite permission"
				button   "size?" [ inni "size? " ]  help "Returns the size of a file or URL's contents"
				return
				button   "split-path" [ inni "split-path " ]  help "Returns a block containing path and target"
				button   "suffix?" [ inni "suffix? " ]  help "Return the suffix (ext) of a filename or url, else NONE"
				button   "undirize" [ inni "undirize" ]  help {Returns a copy of the path with any trailing "/" removed}
				return 
				button   "what-dir " [ inni "what-dir  " ]  help "Prints the active directory path"
				return
				button   "write" [ inni "write /binary /string /append /no-wait /lines /with /allow /mode /custom destination value  " ]  help "Writes to a file, url, or port-spec"
				button   "write-io" [ inni "write-io  " ]  help "Low level write to a port"
				]		
			group-box   [
				h2 "I/O"
				across
				button   "ask" [ inni "ask /hide " ]  help "Ask the user for input"
				button   "browse" [ inni "browse /only " ]  help "Opens the default web browser"
				button   "call" [ inni "call /input  /output  /error  /wait /console /shell /info /show " ]  help "Executes a shell command to run another process"
				button   "checksum" [ inni "checksum /tcp /secure /hash /mehod /key  " ]  help "Returns a CRC or other type of checksum"
				return 
				button   "close" [ inni "close " ]  help "Closes an open port connection"
				return 
				button   "connected?" [ inni "connected?  " ]  help "Returns TRUE when connected to the Internet"
				button   "crypt-strength?" [ inni "crypt-strength?  " ]  help "Returns 'full, 'export or none"
				return
				button   "debase" [ inni {debase  /base "" } ]  help "Converts a string from a different base representation to binary"
				button   "decode-cgi" [ inni {decode-cgi } ]  help "Converts CGI argument string to a block of set-words and value strings"
				button   "decode-url" [ inni {decode-url } ]  help " Decode a URL into an object"
				
				
				return 
				button   "dispatch" [ inni "dispatch [] " ]  help "Wait for a block of ports. As events happen, dispatch port handler blocks"
				button   "enbase" [ inni "enbase  " ]  help "Converts a string to a different base representation"
				
				button   "get-env" [ inni "get-env " ]  help " Gets the value of an operating system environment variable"
				return 
				button   "get-modes" [ inni "get-modes " ]  help "Returns mode settings for a port"
				button   "get-net-info" [ inni "get-net-info " ]  help "(undocumented)"
				
				return
				button   "input" [ inni "input /hide " ]  help "Inputs a string from the console. New-line character is removed"
				button   "input?" [ inni "input? " ]  help "Returns TRUE if input characters are available"
				button   "import-email" [ inni "import-email /multiple " ]  help "Constructs an email object from an email message"
				button   "load" [ inni "load /header /next /library /markup /all " ]  help "Loads a file, URL, or string. Binds words to global context"
				return 
				button   "load-image" [ inni "load  /update /clear " ]  help "Load an image through an in-memory image cache"
				button   "load-stock" [ inni "load-stock  /block " ]  help "Load and return stock image"
				return 
				button   "load-stock-block" [ inni "load-stock-block   " ]  help "Load a block of stock image names. Return block of images"
				button   "load-thru" [ inni "load-thru  /update /binary /to local-file /all /expand /check    " ]  help "Load a net file from the disk cache"
				button   "open" [ inni "open /binary /string /direct /new /write /no-wait /lines /with /allow /mode / custom /skip " ]  help "Opens a new port connection"
				return
				button   "parse-xml" [ inni "parse-xml " ]  help "Parses XML code and returns a tree of blocks"
				button   "prin" [ inni "prin " ]  help "Outputs a value with no line break"
				button   "print" [ inni "print  " ]  help "Outputs a value followed by a line break"
				button   "query" [ inni "query  " ]  help "Returns information about a file, port or URL"
				return
				button   "read" [ inni "read  /binary /string /direct /new /write /no-wait /lines /with /allow /mode / custom /skip " ]  help "Reads from a file, url, or port-spec"
				button   "read-io" [ inni "read-io " ]  help "Low level read from a port"
				button   "read-cgi" [ inni "read-cgi /limit " ]  help "Read CGI data from web server input stream. Return data as string"
				button   "read-net" [ inni "read-net /progress " ]  help "Read a file from the net (web). Update progress bar. Allow abort"
				return 
				button   "read-thru" [ inni "read-thru /progress  /update /expand /check /to " ]  help "Read a net file from thru the disk cache. Returns binary, else none on error"
				button   "script?" [ inni "script? " ]  help "Checks file, url, or string for a valid script header"
				button   "set-modes" [ inni "set-modes " ]  help "Changes mode settings for a port"
				return
				button   "set-net" [ inni "set-net " ]  help "Network setup"
				
				button   "update" [ inni "update " ]  help "Updates the data related to a port"
				
				]	
			group-box  [
				h2 "logic"
				across
				button   "all" [ inni "all [] " ]  help  "Shortcut for AND. Evaluates and returns at the first FALSE or NONE"
				button   "and" [ inni "and " ]  help  "Returns the first value ANDed with the second"
				button   "assert" [ inni "assert " ]  help  "Assert that condition is true, else throw an assertion error"
				return 
				button   "any" [ inni "any [] " ]  help  "Shortcut OR. Evaluates and returns the first value that is not FALSE or NONE"
				button   "any-block?" [ inni "any-block? [] " ]  help  " Returns TRUE for any block values"
				return 
				button   "any-function?" [ inni "any-function? [] " ]  help  " Returns TRUE for any function values"
				button   "any-object?" [ inni "any-object? [] " ]  help  " Returns TRUE for any object values"
				return 
				button   "any-path?" [ inni "any-path? [] " ]  help  " Returns TRUE for any path values"
				button   "any-string?" [ inni "any-string? [] " ]  help  " Returns TRUE for any string values"
				button   "any-type?" [ inni "any-type? [] " ]  help  " Returns TRUE for any type values"
				return 
				button   "any-word?" [ inni "any-word? [] " ]  help  " Returns TRUE for any word values"
				return
				button   "complement" [ inni "complement " ]  help  "Returns the one's complement value"
				return				
				button   "not" [ inni "not " ]  help  "Returns the logic complement"
				button   "true?" [ inni "true? " ]  help  "Returns true if an expression can be used as true"
				button   "!" [ inni "! " ]  help  "Returns the logic complement"
				button   "or" [ inni "or " ]  help  "Returns the first value ORed with the second"
				button   "xor" [ inni "xor " ]  help  "Returns the first value exclusive ORed with the second"				
				]	
			group-box  [
				h2 "Math"
				across
				button   "*" [ inni "*  " ]  help  "Returns the first value multiplied by the second"
				button   "**" [ inni "**  " ]  help  "Returns the first number raised to the second number"
				button   "+" [ inni " +  " ]  help  "Returns the result of adding two values"
				button   "-" [ inni " -  " ]  help  "Returns the second value subtracted from the first"
				button   "/" [ inni " /  " ]  help  "Returns the first value divided by the second"
				button   "//" [ inni "//  " ]  help  "Returns the remainder of first value divided by second"
				button   "abs" [ inni "abs " ]  help  "Returns the absolute value"
				return
				button   ">=" [ inni ">= " ]  help  " Returns TRUE if the first value is greater than or equal to the second value"
				button   ">" [ inni ">= " ]  help  " Returns TRUE if the first value is greater than the second value"
				button   "=" [ inni "= " ]  help  " Returns TRUE if the first value is equal to the second value"
				button   "<" [ inni "< " ]  help  " Returns TRUE if the first value is less than the second value"
				button   "<=" [ inni "<= " ]  help  " Returns TRUE if the first value is less than or equal to the second value"
				return 
				button   "arccosine" [ inni "arccosine " ]  help  "Returns the trigonometric arccosine in degrees"
				button   "arcsine" [ inni "arcsine " ]  help  "Returns the trigonometric arcsine in degrees"
				button   "arctangent" [ inni "arctangent " ]  help  "Returns the trigonometric arctangent in degrees"
				return
				button   "cosine" [ inni "cosine " ]  help  "Returns the trigonometric cosine in degrees"
				button   "even?" [ inni "even? " ]  help  "Returns TRUE if the number is even"
				button   "exp" [ inni "exp " ]  help  "Raises E (natural number) to the power specified"
				button   "log 0" [ inni "log 0 " ]  help  "Returns the base 0 logarithm"
				return
				button   "log-2" [ inni "log-2 " ]  help  "Return the base-2 logarithm"
				button   "log-e" [ inni "log-e " ]  help  "Returns the base-E (natural number) logarithm"
				button   "maximum-of" [ inni "maximum-of [] " ]  help  "Finds the largest value in a series"
				return
				button   "minimum-of" [ inni "minimum-of [] " ]  help  "Finds the smallest value in a series"
				button   "mod" [ inni "mod  " ]  help  "Compute a nonnegative remainder of A divided by B"
				button   "modulo" [ inni "modulo  " ]  help  "Wrapper for MOD that handles errors like REMAINDER. Negligiblevalues (compared to A and B) are rounded to zero"
				return 
				button   "negate" [ inni "negate " ]  help  "Changes the sign of a number"
				button   "negative?" [ inni "negative? " ]  help  "Returns TRUE if the number is negative"
				return
				button   "odd?" [ inni "odd? " ]  help  "Returns TRUE if the number is odd"
				button   "pi" [ inni "pi " ]  help  "3.14159265358979"
				button   "positive?" [ inni "positive? " ]  help  "Returns TRUE if the value is positive"
				button   "random" [ inni "random /seed /secure /only " ]  help  "Returns a random value of the same datatype"				
				return 
				button   "round" [ inni "round /even /down /half-down /floor /ceiling /half-ceiling /to scale"] help  "Returns the nearest integer. Halves round up (away from zero) by default."
				return
				button   "sign?" [ inni "sign? " ]  help  "Returns sign of number as 1, 0, or  "				
				button   "sine" [ inni "sine " ]  help  "Returns the trigonometric sine in degrees"
				button   "square-root" [ inni "square-root " ]  help  "Returns the square root of a number"
				return 
				button   "tangent" [ inni "tangent /radians " ]  help  "Returns the trigonometric tangent in degrees"
				
				button   "zero?" [ inni "zero? " ]  help  "Returns TRUE if the number is zero"
				]
			group-box   [
				h2 "Series"
				across
				button   "ajoin" [ inni "ajoin []" ]  help " Reduces and joins a block of values into a new string"
				button   "alter" [ inni "alter series value " ]  help "If a value is not found in a series, append it; otherwise, remove it"
				button   "append" [ inni "append /only series value " ]  help "Appends a value to the tail of a series and returns the series head"
				button   "apply" [ inni "append /only func [] " ]  help "Apply a function to a reduced block of arguments"
				button   "array" [ inni "array /initial size " ]  help "Makes and initializes a series of a given size"
				return 
				button   "at" [ inni "at series index " ]  help "Returns the series at the specified index"
				button   "back" [ inni "back " ]  help "Returns the series at its previous position"
				
				button   "change" [ inni "change /part /only /dup series value " ]  help "Changes a value in a series and returns the series after the change"
				button   "clear" [ inni "clear " ]  help "Removes all values from the current index series to the tail. Returns at tail"
				button   "compose" [ inni "compose /deep /only [ ( ) ] " ]  help "Evaluates a block of expressions, only evaluating parens, and returns a block"
				return 
				button   "copy" [ inni "copy /part /deep " ]  help "Returns a series copy"				
				button   "cp" [ inni "cp /part /deep " ]  help "Returns a series copy"
				button   "difference" [ inni "difference /case /skip " ]  help "Return the difference of two series"
				button   "exclude" [ inni "exclude " ]  help "Return the first series less the second"
				return 
				button   "extract" [ inni "extract series width " ]  help "Extracts a value from a series at regular intervals"
				button   "empty?" [ inni "empty? " ]  help "Returns TRUE if a series is at its tail"
				
				button   "find" [ inni "find /part /only /case /any /with /skip /match /tail /last /reverse series values " ]  help "nds a value in a series and returns the series at the start of it"
				button   "found?" [ inni "found? " ]  help "Returns TRUE if value is not NONE"
				return
				button   "head" [ inni "head " ]  help "Returns the series at its head"
				button   "head?" [ inni "head? " ]  help "Returns TRUE if a series is at its head"
				button   "index?" [ inni "index? " ]  help "Returns the index number of the current position in the series"
				button   "insert" [ inni "insert /part /only /dup series value " ]  help "Inserts a value into a series and returns the series after the insert"
				return
				button   "intersect" [ inni "intersect /case /skip " ]  help "Create a new value that is the intersection of the two series"
				button   "join" [ inni "join " ]  help "Concatenates values"
				button   "last" [ inni "last " ]  help "Returns the last value of a series"
				button   "last?" [ inni "last? " ]  help " Returns TRUE if the series length is 1"
				return
				button   "length?" [ inni "length? " ]  help "Returns the length of the series from the current position"
				button   "map-each" [ inni "map-each /into " ]  help " Evaluates a block for each value(s) in a series and returns them as a block"
				button   "move" [ inni "move /part /skip /to " ]  help "Move a value or span of values in a series"
				button   "next" [ inni "next " ]  help "Returns the series at its next position"
				return 
				button   "new-line" [ inni "new-line /all /skip  " ]  help "Sets or clears the new-line marker within a block"
				button   "new-line?" [ inni "new-line?  " ]  help "Returns the state of the new-line marker within a block"
				button   "offset?" [ inni "offset? " ]  help "Returns the offset between two series positions"
				button   "pick" [ inni "pick series index " ]  help "Returns the value at the specified position in a series"
				return 
				button   "poke" [ inni "poke series index newdata " ]  help "Returns value after changing its data at the given index"

				button   "remove" [ inni "remove /part " ]  help "Removes value(s) from a series and returns after the remove"
				button   "remove-each" [ inni "remove-each word series body " ]  help "Removes a value from a series for each block that returns TRUE"
				return
				button   "replace" [ inni "replace series search replace " ]  help "Replaces the search value with the replace value within the target series"
				
				button   "repend" [ inni "repend /only series value " ]  help "Appends a reduced value to a series and returns the series head"
				button   "reverse" [ inni "reverse /part " ]  help "Reverses a series"
				button   "reduce" [ inni "reduce  /only " ]  help "Evaluates an expression or block expressions and returns the result"
				return 				
				button   "select" [ inni "select /part /only /case /any /with /skip series value " ]  help "Finds a value in the series and returns the value or series after it"
							
				button   "skip" [ inni "skip series offset " ]  help "Returns the series forward or backward from the current position"
				button   "sort" [ inni "sort /case /skip /compare /part /all /reverse " ]  help "Sorts a series"
				button   "swap" [ inni "swap " ]  help "Swaps elements of a series. (Modifies)"
				button   "tail" [ inni "tail " ]  help "Returns the series at the position after the last value"
				return
				button   "tail?" [ inni "tail? " ]  help "Returns TRUE if a series is at its tail"
				button   "take" [ inni "take /last /part " ]  help "Copies and removes from series. (Modifies)"
				button   "union" [ inni "union /case /skip " ]  help "Returns all elements present within two blocks or strings ignoring the duplicates"
				button   "unique" [ inni "unique /case /skip " ]  help "Returns a set with duplicate values removed"
				return
				button   "++" [ inni "++ " ]  help "Increment an integer or series index. Return its prior value"
				button   "--" [ inni "-- " ]  help "Decrement an integer or series index. Return its prior value"
				return
				group-box  [
					h3 "Data extraction" 
					across
					button   "first" [ inni "first  " ]  help " Returns the first  value of a series"				
					button   "first+" [ inni "first+  " ]  help "Return FIRST of series, and increment the series index"
					button   "second" [ inni "second  " ]  help " Returns the second value of a series"
					button   "third" [ inni "third  " ]  help " Returns the third value of a series"
					return 
					button   "fourth" [ inni "fourth  " ]  help " Returns the fourth value of a series"
					
					button   "fifth" [ inni "fifth  " ]  help " Returns the fifth  value of a series"
					button   "sixth" [ inni "sixth  " ]  help " Returns the sixth  value of a series"
					button   "seventh" [ inni "seventh  " ]  help " Returns the seventh  value of a series"
					return 
					button   "eighth" [ inni "eighth " ]  help " Returns the eighth value of a series"
					button   "ninth" [ inni "ninth  " ]  help " Returns the ninth  value of a series"
					button   "tenth" [ inni "tenth  " ]  help " Returns the tenth value of a series"
					]
				]
			group-box  [
				h2 "String" 
				across
				button   "build-tag" [ inni "build-tag []  " ]  help "Generates a tag from a composed block"
				button   "charset" [ inni {charset ""} ]  help "Makes a bitset of chars"
				button   "detab" [ inni "detab /size " ]  help "Converts tabs in a string to spaces,standard tab size is 4"
				button   "dehex" [ inni "dehex  " ]  help "Converts URL-style hex encoded (%xx) strings"
				return 
				button   "deline" [ inni "deline  " ]  help "Converts string terminators to standard format, e.g. CRLF to LF. (Modifies)"				
				button   "entab" [ inni "entab /size " ]  help "Converts spaces in a string to tabs,standard tab size is 4"
				button   "enline" [ inni "enline /with " ]  help " Converts standard string terminators to current OS format, e.g. LF to CRLF. (Modifies)"
				button   "form" [ inni "form  " ]  help "Converts a value to a string"
				return 
				button   "latin1?" [ inni "latin1?  " ]  help "Returns TRUE if value or string is in Latin  character range (below 256)"
				 
				button   "lowercase" [ inni "lowercase " ]  help "Converts string of characters to lowercase"		
				button   "cr" [ inni "cr " ]  help "char CR"				
				button   "lf" [ inni "lf " ]  help "char LF"
				button   "crlf" [ inni "crlf " ]  help "char CRLF"
				return 
				button   "bs" [ inni "bs " ]  help "char BACKSPACE"
				
				button   "mold" [ inni "mold /only /all /flat " ]  help "Converts a value to a REBOL-readable string"
				
				button   "newline" [ inni "newline " ]  help "New line char"
				button   "newpage" [ inni "newpage " ]  help "New page char"
				button   "tab" [ inni "tab " ]  help "TAB char"
				return 
				button   "escape" [ inni "escape " ]  help "Escape char"
				return
				button   "parse" [ inni "parse /all /case " ]  help "Parses a series according to rules"
				button   "reform" [ inni "reform " ]  help "Forms a reduced block and returns a string with spaces"
				button   "rejoin" [ inni "rejoin " ]  help "Reduces and returns a string without spaces"
				button   "remold" [ inni "remold " ]  help "Forms a reduced block and returns a string with spaces and sqare-bracket"
				return
				button   "trim" [ inni "trim /head /tail /auto /lines /all /with  " ]  help "Removes whitespace from a string. Default removes from head and tail"
				button   "uppercase" [ inni "uppercase /part " ]  help "Converts string of characters to uppercase"
				button   "utf?" [ inni "utf? /utf " ]  help "Returns the UTF encoding from the BOM (byte order marker): + for BE; - for LE"
				button   "invalid-utf?" [ inni "invalid-utf?  " ]  help " Checks for proper UTF encoding and returns NONE if correct or position where the error occurred."
				]	
				
			group-box  [	
				h2 "Time" 
				across
				button  "now" [ inni "now /year /month /day /time /zone /date /weekday /precise " ]  help  "Returns the current local date and time"
				button  "dt" [ inni "dt " ]  help " Delta-time - returns the time it takes to evaluate the block"
				]	
			group-box  [
				h2 "Special" 
				across
				button   "access-os" [ inni "access-os /set" ]  help "Access to various operating system functions (getuid, setuid, getpid, kill, etc.)"
				button   "desktop" [ inni "desktop " ]  help "Display the REBOL viewtop"
				button   "editor" [ inni "editor /app " ]  help "Lauch internal editor"
				button   "help" [ inni "help " ]  help " Prints information about words and values"
				return 
				button   "install" [ inni "install " ]  help "Install Rebol on windows"
				return 
				button   "license" [ inni "license " ]  help "Prints the REBOL license"
				button   "link?" [ inni "link? " ]  help "Returns true if REBOL/Link capability is enabled"
				button   "net-error" [ inni "net-error " ]  help "(undocumented)"
				return 
				button   "open-events" [ inni "open-events " ]  help "(undocumented)"
				button   "parse-header" [ inni "parse-header /multiple" ]  help " Returns a header object with header fields and their values"
				return 
				button   "parse-header-date" [ inni "parse-header-date  " ]  help "(undocumented)"
				button   "path" [ inni "path  " ]  help "Path selection"
				button   "recycle" [ inni "recycle  /off /on /torture " ]  help " Recycles unused memory"
				return 
				button   "run" [ inni "run /as " ]  help "  Runs the system application associated with a file"
				button   "script" [ inni "script " ]  help "Checks file, url, or string for a valid script header"
				button   "secure" [ inni "secure " ]  help " Specifies security policies (access levels and directories). Returns prior settings"
				button   "set-user" [ inni "set-user" ]  help "(undocumented)"
				return 
				button   "set-user-name" [ inni "set-user-name" ]  help "(undocumented)"
				button   "spec-of" [ inni "spec-of " ]  help "Returns a copy of the spec of a function"
				return 
				button   "user-prefs" [ inni "user-prefs " ]  help "Variable that contains user data"
				button   "sound" [ inni "sound " ]  help "Variable that contains suond settings"
				button   "list-env" [ inni "list-env " ]  help "Returns a block of OS environment variables (for current process)"
				return 
				button   "suffix-map" [ inni "suffix-map " ]  help "Variable that contains suffix identifications (pdf, doc...)"
				button   "speed?" [ inni "speed? /no-io /times " ]  help " Returns approximate speed benchmarks [eval cpu memory file-io]"
				button   "uninstall" [ inni "uninstall " ]  help "Uninstall Rebol under windows"
				return 
				button   "upgrade" [ inni "upgrade " ]  help "Download a new version of REBOL if available"
				button   "viewtop" [ inni "viewtop /only " ]  help "Display the REBOL viewtop"
				button   "view-root" [ inni "view-root " ]  help "Variables that contains Rebol user directory"
				return 
				button   "write-user" [ inni "write-user " ]  help "Write network config to user.r file"
				]

				
				] ]; end of core
			"VID"   [ vid_sp: scroll-panel 325x432 [
					
					style button btn white
					style group-box panel 255.255.255 frame black 2x2
					button  pink + 0.0.25 "VID Example" [ inni {Rebol [] view layout [button "Hello World!!!" [alert "Hello word!!!"]]} ]  help "Typical usage of VID"
					group-box  [
						h2 "Inform" 
						across
						button   "alert" [ inni "alert " ]  help " Flashes an alert message to the user. Waits for a user response"
						button   "flash" [ inni "flash " ]  help  "Flashes a message to the user and continues"
						button   "inform" [ inni "inform /offset /title /timeout " ]  help "Display an exclusive focus panel for alerts, dialogs, and requestors"
						button   "notify" [ inni "notify " ]  help "lashes an informational message to the user. Waits for a user response"
						]
					group-box  [
						h2 "Request" 
						across 
				button   "choose" [ inni "choose /style /window /offset /across " ]  help "Generates a choice selector menu, vertical or horizontal"
				button   "confirm" [ inni "confirm /with " ]  help "Confirms a user choice"
				button   "emailer" [ inni "emailer /to /subject " ]  help "Pops up a quick email sender"
				button   "request" [ inni "request /offset /ok /only /confirm /type /timeout " ]  help "Requests an answer to a simple question"
				return
				button   "request-color" [ inni "request-color /color /offset  " ]  help " Requests a color value"
				button   "request-date" [ inni "request-date /offset " ]  help "Requests a date"
				return 
				button   "request-dir" [ inni "request-dir /title /dir  /keep /offset " ]  help "Requests a directory"
				return
				button   "request-download" [ inni "request-download /to " ]  help "Request a file download from the net. Show progress. Return none on error"
				button   "request-file" [ inni "request-file /title /file /filter /keep /omly /path /save " ]  help "Requests a file using a popup list of files and directories"
				return
				button   "request-list" [ inni "request-list title [] " ]  help "Requests a selection from a list"
				button   "request-pass" [ inni "request-pass  /offset /user /only /title  " ]  help "Requests a username and password"
				return
				button   "request-text" [ inni "request-text /offset /default  " ]   help "Requests a text string be entered"
				
				]	
				group-box  [
				h2 "Colors" 
				across 
				button   "aqua" aqua [ inni "aqua  " ]   
				button   "base-effect" effect  base-effect  [ inni "effect base-effect " ]   				
				button   "black" black font [color: white ][ inni "black  " ]   				
				button   "blue" blue [ inni "blue  " ]   
				return 
				button   "brown" coal [ inni "brown  " ]   
				button   "brick " brick  [ inni "brick   " ] 
				button   "beige" beige [ inni "beige  " ] 
				button   "base-color" base-color [ inni " base-color  " ]   
				 return 
				button   "button-color" 44.80.132 [ inni "button-color  " ]   
				button   "bar-color"  bar-color  [ inni "bar-color   " ]   
				button   "bar-effect"  effect bar-effect [ inni "effect bar-effect " ]   
				
				return 
				button   "coal" coal [ inni "coal  " ]   
				button   "cyan" cyan [ inni "cyan  " ]   
				button   "coffee" coffee [ inni "coffee  " ]   
				button   "crimson" crimson [ inni "crimson  " ]
				return 
				button   "forest" forest [ inni "forest  " ]   
				return 
				button   "gray" gray [ inni "gray  " ]   
				button   "green" green [ inni "green  " ]   
				button   "gold" gold [ inni "gold  " ]   
				
				button   "ivory" ivory [ inni "ivory  " ]   
				button   "khaki" khaki [ inni "khaki  " ]   
				return 
				button   "leaf" leaf [ inni "leaf  " ]   
				button   "linen" linen [ inni "linen  " ]   
				
				button   "maroon " maroon  [ inni "maroon   " ]   
				  
				button   "magenta" magenta [ inni "magenta  " ]   
				return 
				button   "mint" mint [ inni "mint  " ]
				return 				
				button   "main-color" main-color [ inni "main-color  " ]   
				button   "navy" navy [ inni "navy  " ]   
				button   "olive" olive [ inni "olive  " ]   
				button   "orange" orange [ inni "orange  " ] 
				return 
				button   "oldrab" oldrab [ inni "oldrab  " ]   
				button   "over-color" over-color [ inni "over-color  " ]   
				button   "pewter" pewter [ inni "pewter  " ]   
				button   "purple"  purple [ inni " purple  " ]   
				return 
				button   "pink"  pink [ inni "pink  " ]   
				button   "papaya"  papaya [ inni "papaya  " ]   
				  
				button   "red" red [ inni "red  " ]   
				button   "rebolor" rebolor [ inni "rebolor  " ]   
				return 
				button   "reblue" reblue [ inni "reblue  " ]
				return 
				button   "silver" silver [ inni "silver  " ] 
				button   "snow" snow [ inni "snow  " ] 
				button   "sienna" sienna [ inni "sienna  " ] 
				button   "sky" sky [ inni "sky  " ] 
				button   "teal" teal [ inni "teal  " ] 	
				return 
				button   "tan" tan [ inni "tan  " ] 
				return 
				button   "violet" violet [ inni "violet  " ] 	
				button   "white" white [ inni "white  " ]   
				button   "water" water [ inni "water  " ]   
				button   "wheat" white [ inni "wheat " ]   
				return 
				button   "yello" yello [ inni "yello " ]   
				
				button   "yellow" yellow [ inni "yellow " ]   
				]
				group-box   [
				h2 "Rebol images"
				across
				image exclamation.gif [inni "exclamation.gif" ] 
				image info.gif [inni "info.gif" ] 
				image logo.gif [inni "logo.gif" ] 
				return 
				image stop.gif [inni "stop.gif" ] 
				image help.gif [inni "help.gif" ] 
				 
				image btn-up.png [inni "btn-up.png" ] 
				image btn-dn.png [inni "btn-dn.png" ] 
				]	
				
				group-box  [
				h2 "Position" 
				across
				button   "across" [ inni "across  " ]   help  "Put items horizontally"
				button   "at" [ inni "at  " ]   help  "Put items at the specified position (pair!)"
				button   "below" [ inni "below  " ]   help  "Put items vertically (standard)"
				button   "guide" [ inni "guide  " ]   help  "Set a guide line"
				button   "indent" [ inni "indent  " ]   help  "Indent horizontally"
				return 
				button   "offset" [ inni "offset  " ]   help  "Set the output face position"
				button   "origin" [ inni "origin  " ]   help  "Specify the layout starting position"
				button   "pad" [ inni "pad  " ]   help  "Insert extra spacing"
				button   "return" [ inni "return " ]   help  "Return to the current guide position"
				button   "space" [ inni "space " ]   help  "Set the auto-spacing used between faces"
				return 
				button   "size" [ inni "size " ]   help  "Set the output face size"
				button   "tabs" [ inni "tabs  " ]   help  "Secify tab space, even a series fo different spaces. Also pairs!"
				button   "tab" [ inni "tab  " ]   help  "Put tab spaces between items"
				]	
				group-box  [
				h2 "Text" 
				across
				button   "title" [ inni "title  " ]   help  "Big title"
				button   "text" [ inni "text  " ]   help  "Normal text"
				button   "head 1" [ inni "h1  " ]   help  "Heding 1"
				button   "head 2" [ inni "h2  " ]   help  "Heading 2"
				return 
				button   "head 3" [ inni "h3  " ]   help  "Heading 3"
				 
				button   "head 4" [ inni "h4  " ]   help  "Heading 4"
				button   "head 5" [ inni "h5  " ]   help  "Heading 5"
				return 
				button   "code" [ inni "code  " ]   help  "Bold code style text"
				button   "tt" [ inni "tt  " ]   help  "Code style text"
				button   "banner" [ inni "banner  " ]   help  "Big coloured title"
				return 
				button   "video text" [ inni "vtext  " ]   help  "text with shadow"
				button   "Video h1" [ inni "vh1  " ]   help  "Heading 1 with shadow"
				button   "Video h2" [ inni "vh2  " ]   help  "Heding 2 with shadow"
				return 
				button   "Video h3" [ inni "vh3  " ]   help  "Heding 3 with shadow"
				button   "Video h4" [ inni "vh4  " ]   help  "Heding 4 with shadow"
				button   "Label" [ inni "label  " ]   help  "bold contrasted text"	
				return 
				button   "base-text" [ inni "base-text  " ]   help  "text"	
				button   "lab" [ inni "lab  " ]   help  "label"	
				button   "lbl" [ inni "lbl  " ]   help  "label"	
				button   "vlab" [ inni "vlab  " ]   help  "video label"	
				button   "txt" [ inni "txt  " ]   help  "text"	
				]
				group-box  [
				h2 "Fields" 
				across
				button  "field" [ inni "field  " ]   help  "Text entry field"
				button  "info" [ inni "info  " ]   help  "Same as FIELD style, but read-only"
				button  "area" [ inni "area  " ]   help  "Text editing area for paragraph entry"
				]
				group-box   [
				h2 "Backgrounds"
				across
				button  "backdrop" [ inni "backdrop  " ]   help "Use an image or effect to fill the background"
				button  "backtile" [ inni "info  " ]   help "Repeat an image to fill the background"
				]
				group-box  [
				h2 "Items" 
				across
				button   "image" [ inni "image  " ]   help  "Display a JPEG, BMP, PNG, or GIF image"
				button   "logo-bar" [ inni "logo-bar  " ]   help  "A vertical Rebol ogo bar"
				button   "box" [ inni "box  " ]   help  "A shortcut for drawing a rectangular box"
				button   "bar" [ inni "bar  " ]   help  "An horzontal bar (change size for vertical)"
				button   "btn" [ inni "btn  " ]   help  "Auto resize button"
				return 
				button   "btn-cancel" [ inni "btn-cancel  " ]   help  "Auto resize button"
				button   "btn-enter" [ inni "btn-enter  " ]   help  "Auto resize button"
				button   "btn-help" [ inni "btn-help  " ]   help  "Auto resize button"
				return 
				button   "icon" [ inni "icon  " ]   help  "Display a thumbnail sized image with text caption"
				button   "led" [ inni "led  " ]   help  "An indicator light"
				button   "anim" [ inni "anim  " ]   help  "Display an animated image"
				button   "button" [ inni "button  " ]   help  "Button"
				return 
				button   "drop-down" [ inni "drop-down  " ]   help  "Drop down list"
				return 
				button   "scroller" [ inni "scroller  " ]   help  "A panel scroller, sizes give the direction"
				 
				button   "toggle" [ inni "toggle  " ]   help  "Similar to BUTTON but has a dual state"
				button   "tog" [ inni "tog  " ]   help  "Similar to BUTTON but has a dual state"
				button   "rotary" [ inni "rotary  " ]   help  "Similar to BUTTON but allows multiple states"
				return 
				button   "choice" [ inni "choice  " ]   help  "A pop-up button that displays multiple choices"
				return 
				button   "check" [ inni "check  " ]   help  "A check box"
				button   "check-line" [ inni "check-line  " ]   help  "A check box"
				button   "check-mark" [ inni "check-mark  " ]   help  "A check box"
				return
				button   "radio" [ inni "radio " ]   help  "A rounded radio button"
				button   "radio-line" [ inni "radio-line " ]   help  "A rounded radio button"
				return 
				button   "arrow" [ inni "arrow  " ]   help  "An arrow button with a beveled edge"
				button   "progress" [ inni "progress  " ]   help  "A sliding progress bar"
				button   "slider" [ inni "slider  " ]   help  "A slider bar"
				button   "panel" [ inni "panel  " ]   help  "A sub-layout"
				return 
				button   "list" [ inni "list  " ]   help  "An iterated sub-layout"				
				button   "text-list" [ inni "text-list  " ]   help  "A simple form of the LIST style"
				]	
				group-box  [	
				h2 "Style" 
				across
				button   "style" [ inni "style  " ]   help "Define a custom style"
				button   "styles" [ inni "styles  " ]   help "Use styles from a stylesheet"
				button   "backcolor" [ inni "backcolor  " ]   help "Set the color of the background"
				button   "backdrop" [ inni "backdrop  " ]   help "Scale an image over the entire layout window"
				return 
				button   "backtile" [ inni "backtile  " ]   help "Tile an image over the entire layout window"				
				]
				group-box  [	
				h2 "Events" 
				across
				button  "sensor" [ inni "sensor  " ]   help "An invisible face that senses mouse events"
				button  "key" [ inni "key  " ]   help "A keyboard shortcut"
				]
				group-box  [
				h2 "Special  functions" 
				across
				button   "brightness?" [ inni "brightness? " ]  help "Returns the monochrome brightness (0.0 to 1.0) for a color value"
				button   "caret-to-offset" [ inni "caret-to-offset  " ]  help " Returns the offset position relative to the face of the character position"
				return 
				button   "center-face" [ inni "center-face  " ] help "Center a face on screen or relative to another face"
				button   "clear-fields" [ inni "clear-fields  " ] help "Clear all text fields faces of a layout"
				button   "confine" [ inni "confine  " ] help "Return the correct offset to keep rectangular area in-bounds"
				return 
				button   "deflag-face" [ inni "deflag-face  " ] help "Clears a flag in a VID face"
				button   "do" [ inni "do []  " ] help "	Evaluate a block"
				button   "do-events" [ inni "do-events " ]  help "When this function is called the program becomes event driven"
				return 
				button   "dump-face" [ inni "dump-face " ]  help "Print face info for entire pane"
				button   "dump-pane" [ inni "dump-pane " ]  help "Print face info for entire pane"
				button   "event?" [ inni "event? " ]  help "Returns TRUE for event values"
				return 
				button   "edge-size?" [ inni "edge-size? " ]  help "Return total size of face edge (both sides), even if missing edge"
				button   "flag-face" [ inni "flag-face " ]  help "Sets a flag in a VID face"
				button   "flag-face?" [ inni "flag-face? " ]  help "Checks a flag in a VID face"
				return 
				button   "find-window" [ inni "find-window " ]  help "Find a face's window face"
				button   "find-key-face" [ inni "find-key-face /check " ]  help "Search faces to determine if keycode applies"
				button   "focus" [ inni "focus " ]  help "Focuses key events on a specific face"
				return 
				button   "get-face" [ inni "get-face " ]  help "Returns the primary value of a face"
				button   "get-style" [ inni "get-style " ]  help " Get the style by its name"
				button   "hide" [ inni "hide " ]  help " Hides a face or block of faces"
				return 
				button   "hide-popup" [ inni "hide-popup /timeout" ]  help "(undocumented)"
				button   "hilight-all" [ inni "hilight-all " ]  help "(undocumented)"
				button   "hilight-text" [ inni "hilight-text " ]  help "(undocumented)"
				return 
				button   "hsv-to-rgb" [ inni "hsv-to-rgb " ]  help "Converts HSV (hue, saturation, value) to RGB"
				return
				button   "in-window?" [ inni "in-window? " ]  help " Return true if a window contains a given face"
				button   "inside?" [ inni "inside? " ]  help "TRUE if both X and Y of the second pair are less than the first"
				return 
				button   "insert-event-func" [ inni "insert-event-func " ]  help "Add a function to monitor global events. Return the func"
				return 
				button   "remove-event-func" [ inni "remove-event-func " ]  help "Remove an event function previously added"
				button   "layout" [ inni "layout /size /pffset /parent /origin /styles /keep /tight " ]   help "Return a face with a pane built from style description dialect"
				return 
				button   "make-face" [ inni "make-face /styles /clones /spec /offset /keep " ]  help "Make a face from a given style name or example face"
				return
				button   "offset-to-caret" [ inni "offset-to-caret face offset" ]  help " Returns the offset in the face's text corresponding to the offset pair"
				button   "outside?" [ inni "outside?" ]  help "TRUE if either X and Y of the second pair are greater than the first"
				button   "overlap?" [ inni "overlap?" ]  help "Returns TRUE if faces overlap each other"
				return 
				button   "rgb-to-hsv" [ inni "rgb-to-hsv " ] help " Converts RGB value to HSV (hue, saturation, value)" 
				button   "reset-face" [ inni "reset-face /no-show " ] help "Resets the primary value of a face"
				button   "resize-face" [ inni "resize-face  /x /y /no-show" ] help "Resize a face"
				return 
				button   "screen-offset?" [ inni "screen-offset? " ] help "Returns the absolute screen offset for any face"
				button   "show" [ inni "show " ] help "Display a face or block of faces"
				button   "show-popup" [ inni "show-popup  /window  /away " ] help "(undocumented)"
				return 
				button   "size-text" [ inni "size-text " ]  help " Returns the size of the text in a face"
				return
				button   "span?" [ inni "span? " ]  help "Returns a block of [min max] bounds for all faces"
				button   "scroll-drag" [ inni "scroll-drag /back /page " ]  help "Move the scroller drag bar"
				button   "scroll-face" [ inni "scroll-face /x /y /no-show " ]  help "Scroll a face. Default is vertical"
				return 
				button   "scroll-para" [ inni "scroll-para  " ]  help "Scroll a text face, given a scroller/slider face"
				button   "set-face" [ inni "set-face /no-show " ]  help "Sets the primary value of a face. Returns face object (for show)"
				button   "set-font" [ inni "set-font  " ]  help "(undocumented)"
				return 
				button   "set-para" [ inni "set-para  " ]  help "(undocumented)"
				button   "set-style" [ inni "set-style /style " ]  help "Set a style by its name"
				button   "size-text" [ inni "size-text" ]  help "Returns the size of the text in a face"
				return 
				button   "stylize" [ inni "stylize /master /styles " ]  help " Return a style sheet block"
				button   "textinfo" [ inni "textinfo " ]  help "Sets the line text information in an object for a face"
				button   "unfocus" [ inni "unfocus  " ]  help " Removes the current key event focus"
				button   "unview" [ inni "unview /all /only" ]  help " Closes window(s)"
				return 
				button   "unlight-text" [ inni "unlight-text" ]  help "(undocumented)"
				return
				button   "view" [ inni "view /new /offset /options /title " ]  help "Displays a window face"
				button   "viewed?" [ inni "viewed? " ]  help "Returns TRUE if face is displayed"
				button   "within?" [ inni "within? point offset size " ]  help " Return TRUE if the point is within the rectangle bounds"
				return 
				button   "win-offset?" [ inni "win-offset? " ]  help "Returns the offset of a face within its window"
				]			
					]] ;end fo VID
			"DRAW" [ 
				draw_sp: scroll-panel 325x432  [
				style button btn white
				style group-box panel 255.255.255 frame black 2x2
				button  pink "DRAW example" [ inni {Rebol [] view layout [box 300x200 effect [draw [
									pen navy fill-pen yellow
									box 20x20 80x80
									fill-pen 0.200.0.150
									pen maroon
									box 30x30 90x90
									image logo.gif 150x100   
									line 2x2  2x150 150x100 2x2
									pen green
									shape [ move 100x100
										arc 200x100
										line 100x100
										] 
									]]]} ]   help "Example"
			
			group-box  [
				h2 "Effects" 
				across
				button   "anti-alias" [ inni "anti-alias  " ]   help "Antialias on/off (on is standard)"
				button   "clip" [ inni {clip 0x0 10x10  
				...  ; draw commands
				clip none } ]   help  "The drawing commands between clips will be displayedonly in the clip region"
				button   "fill-pen" [ inni "fill-pen  " ]   help {fill-pen color (grad-mode  grad-offset grad-start-rng grad-stop-rng grad-angle grad-scale-x 
				grad-scale-y grad-color1 grad-color2 grad-color3 ... image)}
				button   "fill-rule" [ inni "fill-rule  " ]   help "fill-rule mode"
				return 
				button   "font" [ inni "font  " ]   help "font font-object"
				return 
				button   "gamma" [ inni "gamma  " ]   help "gamma gamma-value"
				button   "invert-matrix" [ inni "invert-matrix  " ]   help "Applies an algebric matrix inversion operation on the current transformation matrix"
				button   "image-filter" [ inni "image-filter  " ]   help "image-filter filter-type"
				return 
				button   "line-cap" [ inni "line-cap  " ]   help "line-cap butt/square/round"
				button   "line-join" [ inni "line-join  " ]   help "line-join miter/miter-bevel/round/bevel"
				button   "line-pattern" [ inni "line-pattern  " ]   help "line-pattern stroke-size dash-size (stroke-size dash-size stroke-size dash-size ...)"
				return 
				button   "line-width" [ inni "line-width  " ]   help "line-width size"
				button   "matrix" [ inni "matrix  " ]   help "Premultiply the current transformation matrix with the given block"
				button   "pen" [ inni "pen  " ]   help "pen (stroke-color dash-color image)"				
				button   "push" [ inni "push  " ]   help "Stores the current matrix setup in stack"
				return 
				button   "reset-matrix" [ inni "reset-matrix  " ]   help "Resets the current transformation matrix to its default values"
				button   "rotate" [ inni "rotate  " ]   help "Sets the clockwise rotation, in degrees, for drawing commands"
				button   "scale" [ inni "scale  " ]   help "Sets the scale for drawing commands"
				return 
				button   "transform" [ inni "transform  " ]   help "You can apply a transformation such as translation, scaling, and rotation to any DRAW result"
				button   "translate" [ inni "translate  " ]   help "translate offset"
				
				]
			
			group-box  [	
				h2 "Geometry" 
				across
				button   "arc" [ inni "arc  " ]   help "Arc center radius (angle-start angle-end angle-lenght closed)"
				button   "arrow" [ inni "arrow  0x0" ]   help "arrow mode-x-mode"
				button   "box" [ inni "box  " ]   help "box up-left low-right (radius)"
				button   "circle" [ inni "circle  " ]   help "circle center radiusX (radiusY)"
				button   "curve" [ inni "curve  " ]   help "curve point point point (point)"
				return 
				button   "image" [ inni "image  " ]   help "image (up-left low-right/up-right low-left low-right key-color border)"
				return 
				button   "line" [ inni "line  " ]   help "line point point (point point ...)"
				button   "polygon" [ inni "polygon  " ]   help "polygon point point point (point point ...)"				
				button   "spline" [ inni "spline  " ]   help "spline  (segmentation closed) point point (point point ...)"
				button   "text" [ inni "text  " ]   help "text sting offset anti-aliased/vectorial/aliased"
				
				]
			
			group-box  [	
				h2 "Shape commands" 
				across
				button   "shape" [ inni "shape []  " ]   help "Draws shapes using the SHAPE sub-dialect, for relative positions"
				button   "arc" [ inni "arc  " ]   help "arc center radiusX radiusY angle sweep true/false"
				button   "curv" [ inni "curv  " ]   help "curv point point (point point ...)"
				button   "curve" [ inni "curve  " ]   help "curve point point point (point ...)"
				button   "hline" [ inni "hline  " ]   help "hline endX"
				return 
				button   "line" [ inni "line  " ]   help "line point (point point ...)"
				return 
				button   "move" [ inni "move  " ]   help "Set's the starting point for a new path without drawing anything"
				button   "qcurve" [ inni "qcurve  " ]   help "qcurve point"
				button   "vline" [ inni "vline  " ]   help "vline endY"
				]

				]]; end of DRAW
				
			"Your variables" [				
				style button btn white
				style group-box panel 255.255.255 frame black 2x2
				button mint "Update!" [ 
			
			either (attempt [findall t] ) [listaoggetti: findall t ] [alert {There is an error, check " and {}} ]
			
			clear  wordsyv/data
			 insert wordsyv/data  (select listaoggetti "words")
			 clear blocksyv/data
			 insert blocksyv/data (select listaoggetti "blocks")
			 clear functionsyv/data
			insert functionsyv/data (select listaoggetti "functions")
			clear objectsyv/data
			insert objectsyv/data (select listaoggetti "objects")
			show [ wordsyv  blocksyv  functionsyv objectsyv ]
			]
		
		yv_sp: scroll-panel 325x400 [
			label "Words"
			wordsyv: text-list 
			label "Blocks"
			blocksyv: text-list 
			label "Functions"
			functionsyv: text-list 
			label "Objects"
			objectsyv: text-list
			]
		
		]; end of "your vars"
				
		] with [ ;this give the resize window to the tab panel
			;patched the "original" resize feel --cyphre
			;note: the layout pane in tab-area subface must be resized as well in this usage case --cyphre
			feel: make feel [
				resize: func [f size+][
					either pair? size+ [
						f/tab-area/pane/size/y: f/size/y: f/size/y + size+/y
					] [
						f/tab-area/pane/size: f/size: size+
					]
					show f
				]
			]
		]
		t: area-tc  550x500	
		
	]
	
;function to find all variables
findall: func [ a_findall /local temp temp2  str-tmp dt line ] [
	dt: head a_findall/data
	str-tmp: copy "" 	
	foreach item dt [
		line: second item ; on transfert le  pointeur vers le document dans data vers un autre pointeur  
		append str-tmp copy/part  line any [ find line newline tail line] ;on copy jusqu'a newline ou jusqu'a la fin 
		append str-tmp newline
		]
	temp: copy []
	temp: copy to-block  str-tmp
	variabili: copy []
	funzioni: copy []
	blocchi: copy []
	oggetti: copy []
	foreach item temp [
		tipo: false
			if ((type? item) = set-word!) [	
			if   any [  
				temp/2  = 'func 
				temp/2 = 'has
				temp/2 = 'does
				] [ append funzioni item   tipo: true ]
			if   (  temp/2 = 'make ) [ append oggetti  item tipo: true]
			if   ( (type? temp/2 ) = block! ) [ append blocchi  item tipo: true]
			if tipo = false [ append variabili  item ]		
			]
		temp: next temp
		]	
	sort funzioni
	sort oggetti
	sort blocchi
	sort variabili
	return (reduce [ "functions"  funzioni "objects" oggetti "blocks" blocchi "words" variabili])	
	]


;to launch soirce or examples
lancia: func [ temp /local corpo ] [	
	corpo: copy temp
	insert corpo "Rebol [] "
	write %temp.r  corpo	
	launch (clean-path %temp.r) ;clean-path is necessary on Linux
	]




;other windows

aboutpage: layout [
title "Rebolide" 
text bold reform ["Version: " system/script/header/version ]
text bold "Author: Massimiliano Vessi"
text as-is  200 { Rebolide is an IDE for Rebol. It has syntax coloring and big manuals inside.
This script should make it easier to learn Rebol.
Feel free to contact me.
If you found bugs or errors please email me.}

text italic  form  [ "maxint" "@" "tiscali.it"] ;this avoid rebol.org antispam correction, that it messes up all emails

text  200 {Thanks to Carl sassenrath, Steeve, Maxim, Coccinelle, Cyphre, Graham, Nick Antonaccio, Semseddin Moldibi, Zoltan Eros, R. v.d.Zee}
]


;style definition
rebolide-style: stylize [
	tooltip: code as-is 340 black gold edge [color: black size: 2x2]
	heading: h2
	text: text as-is 340	para [indent: 10x0 ]
	link: text blue italic underline
    ]

;*************************
;VID guide page


guida_vid: auto-resize layout [
	styles rebolide-style
	across 
	h1  "REBOL/View VID Developer's Guide"
	return
	text italic bold "You can click on the examples to see the results"
	return 
	scroll-panel 400x400  [
		across
		text {This document describes VID, the Visual Interface Dialect for creating graphical user interfaces in REBOL 2.
By their nature, graphical user interfaces (GUI) are more descriptive than they are functional. In REBOL, the Visual Interface Dialect (VID) provides an efficient method of describing GUIs. VID is implemented as a layer that rides on top of the REBOL/View graphical compositing system. VID provides shortcut expressions that are automatically translated into View objects and functions. You can seamlessly combine VID and View code and data for great power and flexibility.}
return
heading "Layout Concepts"
return 
text {A VID layout is a block of words and values that is used to describe a GUI. It provides the names, attributes, and operations that are used to display text areas, buttons, checkboxes, input fields, slider bars, and more. The format of the VID layout block is organized according to the rules of VID.}
return 
heading {Layout Structure}
return 
text   {A layout block consists of:
"Keywords"  Layout keywords that describe face positioning and other layout attributes.
"Styles"	Face styles that are used to specify the faces that are displayed. These can be predefined styles like TITLE, BUTTON, FIELD, TEXT, or your own custom styles.
"Facets"	Attributes that describe variations in the style of a face, such as the size, color, alignment, border, or image.
"Variables"  Definitions that hold either faces or layout positions. These variables can be used later to access face objects or to affect face positions.
"Styledefs" New style definitions that are to be used within the layout. Single styles or entire stylesheets can be provided.

These elements can be mixed and matched in whatever order is necessary to create a layout.}
return 
label "Simple Examples"
return 
text {The easiest way to learn VID layouts is by example. The single line below creates and displays a window that contains the obligatory "Hello World!" example:}
return 
tooltip {view layout [title "Hello World!"]} [ lancia  { view layout [title "Hello World!"]  }] 
return 
text {The layout block contains the VID description of what to display. The block is a dialect, not normal REBOL, and it is passed to the LAYOUT function to create the faces for the layout. The result of the LAYOUT function is passed to the VIEW function to display it on your screen:
The TITLE word is a predefined style and is followed by values and attributes that affect that style. In the example above, a string value provides the title text.
VID provides more than 40 predefined styles. For example, you can replace the TITLE style with the video BANNER style:}
return 
tooltip {view layout [banner "Hello World!!!"]} [ lancia {view layout [banner "Hello World!!!"]} ]
return 
text "Within a layout, multiple styles can be provided. Each style creates another element of the interface. The example below shows a video heading (vh2), followed by text, then by a button:"
return 
tooltip {view layout [
    vh2 "Layout Definition:"
    text "Layouts describe graphical user interfaces."
    button "Remember"
]} [ lancia { view layout [
    vh2 "Layout Definition:"
    text "Layouts describe graphical user interfaces."
    button "Remember"
]} ]

return 
text "Thousands of effects and variations are possible within a layout by specifying style attributes called facets. These attributes follow the style word. Here is an example that shows how an elaborate layout can be created in a few lines of VID code:"
return 
tooltip {view layout [
    backdrop effect [gradient 1x1 180.0.0 0.0.100]
    vh2 "Layout Definition:" 200x22 yellow
        effect [gradmul 1x0 50.50.50 128.128.128]
    vtext bold italic "Layouts describe graphical user interfaces."
    button "Remember" effect [gradient 0.0.0]
]} [ lancia {view layout [
    backdrop effect [gradient 1x1 180.0.0 0.0.100]
    vh2 "Layout Definition:" 200x22 yellow
        effect [gradmul 1x0 50.50.50 128.128.128]
    vtext bold italic "Layouts describe graphical user interfaces."
    button "Remember" effect [gradient 0.0.0]
]}]

return 
text {Layouts can specify as many faces as your interface requires. For example, this layout uses styles, a backdrop, a heading, text labels, text input fields, and buttons:}
return 
tooltip {view layout [
    style lab label 100 right
    across
    vh2 "Provide Your Information:" gold return
    lab "User Name:" field return
    lab "Email Address:" field return
    lab "Date/Time:" field form now return
    lab "Files:" text-list data load %. return
    lab
    button 96 "Save"
    button 96 "Cancel"
    return
]} [lancia {view layout [
    style lab label 100 right
    across
    vh2 "Provide Your Information:" gold return
    lab "User Name:" field return
    lab "Email Address:" field return
    lab "Date/Time:" field form now return
    lab "Files:" text-list data load %. return
    lab
    button 96 "Save"
    button 96 "Cancel"
    return
]}]

return 
text "The example shows how multiple styles can be specified within a layout."
return 
heading "Layout Function"
return 
text {The LAYOUT function takes a layout block as an argument and returns a layout face as a result. The block describes the layout according to the rules of the Visual Interface Dialect. The block is evaluated and a face is returned.
The result of LAYOUT is can be passed directly to the VIEW function, but it can also be set to a variable or returned as the result of a function. The line:}
return 
tooltip {view layout block}
return 
text "can also be written as:"
return 
tooltip {window: layout block
view window}
return 
text "The result of the layout function is a face and can be used in other layouts. More on this later."
return 
heading "Layout Refinements"
return 
text {In most cases, the LAYOUT function is called without refinements; however, these refinements are available when necessary:
/size	A PAIR! that specifies the size of the resulting face. This forces the face to be of a fixed size before the layout is performed. The default is to size the face dynamically based on the placement of items within the layout.
/offset	A PAIR! that provides the offset to where the window will be displayed within its parent face (often the screen).
/styles	A stylesheet block that was created with the STYLIZE function. A stylesheet defines custom styles used within the layout. This is equivalent to the STYLES keyword within a layout.
/origin	A PAIR! that sets the pixel offset to the first face within the layout. This is equivalent to the ORIGIN keyword within a layout.
/parent	Specifies the style of the top-level face that is produced from the layout. The parent can be specified as a style name or as an actual instance of the style.
/options	Specifies the VIEW options when the face is displayed with the VIEW function. See the VIEW function for details.}
return 
heading "Keywords"
return 
text {Here is a summary of the layout keywords that describe face positioning and other layout attributes. These are reserved words. These words cannot be used for style names or for variables within a layout.
across	Set auto-layout to horizontal direction.
at	Locate a face to an absolute position.
backcolor	Set the color of the background.
below	Set auto-layout to vertical direction.
do	Evaluate a block.
guide	Set a guide line.
indent	Indent horizontally.
offset	Set the output face position.
origin	Specify the layout starting position.
pad	Insert extra spacing.
return	Return to the current guide position.
style	Define a custom style.
styles	Use styles from a stylesheet.
space	Set the auto-spacing used between faces.
size	Set the output face size.
tabs	Set tab stops.
tab	Advance to next tab position.

Each of these keywords is described in more detail in sections of this document.}
return 
heading "Face Styles"
return 
text {Face styles are used to specify the faces that are displayed. These can be predefined styles, or they can be your own custom styles.}
return 
heading {Predefined Styles}
return 
text {Predefined styles are part of VID and can be used in three ways.
-You can use any predefined style as-is and it will provide its default look and feel.
-You can specify variations on a style by providing facets such as color, size, font, effects, etc.
-You can use a style as the basis for defining a new custom style.

The predefined styles are listed below. For more information about each of these styles, refer to the Styles chapter (a separate document).
title	Document title heading.
h1	Top level heading used for documents.
h2	Heading use for document sections.
h3	Heading used for subsections.
h4	Heading used below subsections.
h5	Heading used below subsections.
banner	Title heading with video style.
vh1	Section heading used for video style.
vh2	Section heading used for video style.
vh3	Section heading used for video style.
text	Document body text.
txt	An alias for TEXT style above.
vtext	Inverse video body text.
tt	The teletype font for fixed width text.
code	Same as TT except defaults to bold.
label	Used for specifying GUI text labels.
field	Text entry field.
info	Same as FIELD style, but read-only.
area	Text editing area for paragraph entry.
sensor	An invisible face that senses mouse events.
image	Display a JPEG, BMP, PNG, or GIF image.
box	A shortcut for drawing a rectangular box.
backdrop	Scale an image over the entire layout window.
backtile	Tile an image over the entire layout window.
icon	Display a thumbnail sized image with text caption.
led	An indicator light.
anim	Display an animated image.
button	A button that goes down on a click.
toggle	Similar to BUTTON but has a dual state.
rotary	Similar to BUTTON but allows multiple states.
choice	A pop-up button that displays multiple choices.
check	A check box.
radio	A rounded radio button.
arrow	An arrow button with a beveled edge.
progress	A sliding progress bar.
slider	A slider bar.
panel	A sub-layout.
list	An iterated sub-layout.
text-list	A simple form of the LIST style.
key	Keyboard shortcut.

Here is an example that shows most of these custom styles:}
return 
tooltip {view layout [title "Document Title"
h1 "Heading 1"
h2 "Heading 2"
h3 "Heading 3"
h4 "Heading 4"
h5 "Heading 5"
banner "Video Title"
vh1 "Video heading 1"
vh2 "Video heading 2"
vh3 "Video heading 3"
text "Document body text"
tt "The teletype font for fixed width text"
code "Same as TT except defaults to bold"
vtext "Inverse video body text"
txt "An alias for BODY style above"
label "Used for specifying GUI text labels"
lbl "The video equivalent of LABEL"
field "Text entry field"
info "Same as FIELD style, but read-only"
area "Text editing area for paragraph entry"
do [if not exists? %nyc.jpg [
 write/binary %nyc.jpg read/binary %../nyc.jpg
 ]]
image %nyc.jpg 100x100
box blue
icon %nyc.jpg "NYC"
led
button "Button"
toggle "Toggle"
rotary "Rotary"
choice "Choice"
check
radio
arrow
progress
slider 200x16
text-list "A simple form of the LIST style"]} [ lancia {view layout [title "Document Title"
h1 "Heading 1"
h2 "Heading 2"
h3 "Heading 3"
h4 "Heading 4"
h5 "Heading 5"
banner "Video Title"
vh1 "Video heading 1"
vh2 "Video heading 2"
vh3 "Video heading 3"
text "Document body text"
tt "The teletype font for fixed width text"
code "Same as TT except defaults to bold"
vtext "Inverse video body text"
txt "An alias for BODY style above"
label "Used for specifying GUI text labels"
lbl "The video equivalent of LABEL"
field "Text entry field"
info "Same as FIELD style, but read-only"
area "Text editing area for paragraph entry"
do [if not exists? %nyc.jpg [write/binary %nyc.jpg read/binary %../nyc.jpg]]
image %nyc.jpg 100x100
box blue
icon %nyc.jpg "NYC"
led
button "Button"
toggle "Toggle"
rotary "Rotary"
choice "Choice"
check
radio
arrow
progress
slider 200x16
text-list "A simple form of the LIST style"]}]


return 
heading "Facets"
return 
text "All of the styles above can be provided with additional information to vary their size, color, text, alignment, background, and more. This is described in detail in the Facets section below."
return 
heading "Custom Styles"
return 
text "Any of the styles listed above can be used as the base style for creating your own custom style. This is covered in the Style Definition section later in this document."
return 
heading "Style Facets"
return 
text {Within a layout, each face is specified by a style word that identifies the look and feel of the face. Each style word can be followed by optional facet attributes that further modify the face. Facets can control the text, size, color, images, actions, and most other aspects of a face.

All facets are optional. For example, the example below shows how you can create a button with a variety of facets. The facets can be provided alone or in combination.}
return 
tooltip {button
button "Easy"
button "Easy" 40x40
button "Easy" oldrab
button "Easy" [print "Fun"]
button "Easy" 40x40 maroon [print "Fun"]} [ lancia { view layout [button
button "Easy"
button "Easy" 40x40
button "Easy" oldrab
button "Easy" [print "Fun"]
button "Easy" 40x40 maroon [print "Fun"]]}]


return 
text {Facets can appear in any order. You don't need to keep track of which goes first. All of these mean the same thing:}
return 
tooltip{
button "Easy" 40x40 navy [print "Fun"]
button navy "Easy" 40x40 [print "Fun"]
button 40x40 navy "Easy" [print "Fun"]
button [print "Fun"] navy 40x40 "Easy"} [ lancia { view layout [
button "Easy" 40x40 navy [print "Fun"]
button navy "Easy" 40x40 [print "Fun"]
button 40x40 navy "Easy" [print "Fun"]
button [print "Fun"] navy 40x40 "Easy"]}]


return 
heading "Text Facets"
return 
text "Text string facets provide the text used for all faces. The text can be written as a short string in quotes, a long multiline string in braces, or provided as a variable or function that contains the string."
return 
tooltip {
text "Example string"
text {This is a long, multilined text 
section that is put in a braced
string and will be displayed on the page.} 
text text-doc
text read %file.txt}
return 
text "For some faces styles, more than one string can be provided. For instance, a choice button accepts multiple strings:"
return 
tooltip {choice "Steak" "Eggs" "Salad"} [lancia {view layout [ choice "Steak" "Eggs" "Salad"]}]
return 
heading "Size Facets"
return 
text "The size of a face can be specified as a pair that provides the width and height of the face in pixels:"
return 
tooltip{image %nyc.jpg 100x200
text "example" 200x200
button "test" 50x24}[lancia {  view layout [ image %nyc.jpg 100x200
text "example" 200x200
button "test" 50x24]}]

return 
text "The width of a face can also be expressed an integer, leaving the height to be computed automatically:"
return 
tooltip {text "example" 200
button "test" 50}[ lancia {  view layout [ text "example" 200
button "test" 50]}]

return 
heading "Color Facets"
return 
text "A color is written as a tuple that provides the red, green, and blue components of the color."
return 
tooltip{image %nyc.jpg 250.250.0
text "example" 0.0.200
button "test" 100.0.0} [ lancia {  view layout [ image %nyc.jpg 250.250.0
text "example" 0.0.200
button "test" 100.0.0]}]

return 
text "The are also about 40 predefined colors in REBOL that can be used:"
return 
tooltip {text red "Warning"
text blue "Cool down"
text green / 2 "Ok"} [ lancia {view layout [ text red "Warning"
text blue "Cool down"
text green / 2 "Ok"]}]
return 
text {Notice in the last case how the color can be reduced by dividing it by two.

Some faces accept multiple colors. For instance:}
return 
tooltip{toggle "Test" red green
rotary "Stop" red "Caution" yellow "Go" green}[ lancia {view layout [ toggle "Test" red green
rotary "Stop" red "Caution" yellow "Go" green]}]
return 
heading "Image Facets"
return 
text "An image can be provided as a filename, a URL, or as image data."
return 
tooltip{image %nyc.jpg
image http://www.rebol.com/view/nyc.jpg
button "Test" %nyc.jpg}[ lancia {view layout [ image %nyc.jpg
image http://www.rebol.com/view/nyc.jpg
button "Test" %nyc.jpg]}]
return 
text "An image can also be loaded and used as a variable:"
return 
tooltip {town: %nyc.jpg
view layout [
image town
image 30x30 town
icon town "NYC"]}[ lancia { town: %nyc.jpg
view layout [
image town
image 30x30 town
icon town "NYC"]}]
return 
heading "Action Facets"
return 
text {An action is specified as a block. The action makes a face "hot". When a user clicks on the face, the block will be evaluated.}
return 
tooltip {image %nyc.jpg [print "hello"]
text "example" [print "there"]
button "Test" [print "user"]} [ lancia {view layout [image %nyc.jpg [print "hello"]
text "example" [print "there"]
button "Test" [print "user"]]}]
return 
text {Some styles accept a second block that is used as an alternate action (right-click action). For example:}
return 
tooltip {text "Click Here" [print "left click"] [print "right click"]} [ lancia {view layout [text "Click Here" [print "left click"] [print "right click"]]}]
return 
heading "Character Facets"
return 
text {A shortcut key is written as a character (a string with a # before it). If the user presses a shortcut key, the action block will be evaluated as if the user clicked on it.}
return 
tooltip {image %nyc.jpg #"i" [print "hello"]
text "example" #"^^t" [print "there"] ; this is CTRL+T
button "Test" #" " [print "user"] ;space } [ lancia {view layout [image %nyc.jpg #"i" [print "hello"]
text "example" #"^t" [print "there"]
button "Test" #" " [print "user"] ]}]
return 
heading "Face Facet Blocks"
return 
text {Note that facet blocks are most useful when used in conjunction with custom styles.
font	A font block is used to specify other details about a font, such as its font name, point size, color, shadow, alignment, spacing, and more:}
return 
tooltip{text "black" font [color: 255.255.255 size: 16 shadow: none]} [ lancia {view layout [text "black" font [color: 255.255.255 size: 16 shadow: none]]}]
return 
text {para	A para block specifies the paragraph attributes of a text face. This is where you adjust the spacing between paragraphs, margins, and other values.}
return 
tooltip{text "test" para [origin: 10x10 margin: 10x10]} [ lancia {view layout [text "test" para [origin: 10x10 margin: 10x10]]}]
return 
text "edge	An edge block gives you a way to control the edge around the outside of a face. You can set its color, size, and effect."
return 
tooltip {image %nyc.jpg edge [size 5x5 color: 100.100.100 effect: [bevel]]}[ lancia {view layout [ image %nyc.jpg edge [size 5x5 color: 100.100.100 effect: [bevel]]]}]
return 
text "effect	An effect block specifies special graphic effects for a face. Many effects are possible, such as gradients, colorize, flip, rotate, crop, multiply, contrast, tint, brighten, and various combinations."
return 
tooltip{image %nyc.jpg effect [contrast 20]
image %nyc.jpg effect [tint 120 brighten 30]
button "Test" effect [gradient 0x1 200.0.0]} [lancia { view layout [image %nyc.jpg effect [contrast 20]
image %nyc.jpg effect [tint 120 brighten 30]
button "Test" effect [gradient 0x1 200.0.0]]}]
return 
text "with	The with block allows you to specify any other type of face characteristic using standard REBOL object format."
return 
heading "Attribute Keywords"
return 
text "These words control the layout as it is being created. They affect the placement of faces within the layout."
return 
text bold "Size "
return 
text "SIZE sets the size of the layout face. This must be done at the beginning of a layout before any styles are used. For example, the simple layout:"
return 
tooltip {size 200x100
h2 "Size Example"} [lancia { view layout [size 200x100
h2 "Size Example"]}]

return 
text "This is equivalent to the /size refinement in the LAYOUT function. If no size is specified, then the layout is auto-sized based on the styles used within it."
return 
text bold "Offset"
return 
text "OFFSET specifies the position of the layout face within its parent face (often the screen). This is the same as the /offset refinement in the LAYOUT function."
return 
tooltip {offset 10x32}
return 
text "The offset need not be specified in the layout. It can be specified in the View if necessary. The default offset is 25x25."
return 
text bold "Origin"
return 
text {ORIGIN sets the starting X and Y position of faces in the layout. The origin is specified as the number of pixels from the upper left corner of the layout window. However, the origin also determines the amount of spacing between the last face and the bottom right of the layout. The default origin is 20x20.
The example below uses an origin that is smaller than usual:}
return 
tooltip {origin 4x2
text bold "Origin at 4x2"} [ lancia{ view layout [ origin 4x2
text bold "Origin at 4x2"]}]
return 
text "If an integer is specified for the origin, then both the X and Y positions will be set to that value, as in this example:"
return 
tooltip {origin 50
text bold "Origin at 50x50"}  [ lancia{ view layout [origin 50
text bold "Origin at 50x50"]}]
return 
text {When no pair value is provided, the origin word returns the layout to its original origin position.}
return 
tooltip{box 34x40 beige
origin
text bold "Back at Origin"} [lancia { view layout [
box 34x40 beige
origin
text bold "Back at Origin"]}]

return text {As you can see from the above examples, the origin also has an affect on the size of the resulting face when no size has been provided.

Setting the origin is especially important when creating panels and lists. Frequently the origin in lists is set to zero. For example:}
return tooltip {vh2 "Films:"
list 144x60 [
    origin 0
    across
    text 60
    text 80
] data [
    ["Back to the Future" "1:45"]
    ["Independence Day" "1:55"]
    ["Contact" "2:15"]
]} [lancia { view layout [
vh2 "Films:"
list 144x60 [
    origin 0
    across
    text 60
    text 80
] data [
    ["Back to the Future" "1:45"]
    ["Independence Day" "1:55"]
    ["Contact" "2:15"]
]]}]



return text "The block provided to the LIST style is a layout with an origin of zero."
return heading "Auto-Layout Direction"
return text bold "Below"
return text {BELOW specifies a vertical layout for faces that follow it. It is used along with ACROSS for auto layout of faces.
BELOW is the default layout direction when none is specified. For example:}
return tooltip {button "Button 1"
button "Button 2"
button "Button 3"} [lancia { view layout [ 
button "Button 1"
button "Button 2"
button "Button 3"]}]
return text "You can switch between BELOW and ACROSS at any time during a layout. When BELOW is used, faces will be positioned below the current face. The example:"
return tooltip {across
button "Button 1"
button "Button 2"
return
below
button "Button 3"
button "Button 4"} [lancia { view layout [ 
across
button "Button 1"
button "Button 2"
return
below
button "Button 3"
button "Button 4"]}]
return text bold "Across"
return text {ACROSS specifies a horizontal layout for faces that follow it. It is used along with BELOW for auto layout of faces.
When ACROSS is used, faces will be located to the right of the current face. The example:}
return tooltip {across
button "Button 1"
button "Button 2"
button "Button 3"} [lancia { view layout [ 
across
button "Button 1"
button "Button 2"
button "Button 3"]}]
return text "You can switch between ACROSS and BELOW at any time during a layout."
return tooltip {vh2 "Example"
across
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"
return} [lancia { view layout [ vh2 "Example"
across
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"
return]}]
return text "The above example would display:"
return text bold "Return"
return text {RETURN advances the position to the next row or column, depending on the layout direction. If the layout direction is across, return will start a new row. If the direction is below, return will start a new column.
The example:}
return tooltip {across
text "Name:" 100x24 right
field "Your name"
return
text "Address:" 100x24 right
field "Your address"
return}[lancia { view layout [ 
across
text "Name:" 100x24 right
field "Your name"
return
text "Address:" 100x24 right
field "Your address"
return]}]
return text "The position of the column is relative to the origin or to a guide."
return heading "Spacing"
return text "Space"
return text {SPACE sets the auto-spacing to use between faces within the layout. The spacing can be changed at any time within your layout. Either a pair or an integer can be given. If you specify a pair, both the vertical and horizontal spacing is set.
Compare these two cases. The first specifies a small space:}
return tooltip {space 2x4
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"} [lancia { view layout [ 
space 2x4
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"]}]
return text "The second uses a larger space:"
return tooltip {space 20x16
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"
}[lancia { view layout [ 
space 20x16
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"]}]
return text "If the space you specify is an integer, only the spacing in the current direction (across or below) is set. The line would look like:"
return  tooltip {space 5} [lancia { view layout [ space 5]}]
return 
text bold "Pad"
return 
text "PAD inserts extra spacing between the current position and the position of the next face. The distance can be specified as an integer or a pair. When it is a pair, the space will be added both horizontal and vertically."
return tooltip {text "Bar below"
pad 20x4
box 50x3 maroon} [lancia { view layout [ 
text "Bar below"
pad 20x4
box 50x3 maroon]}]

return text {When the PAD is an integer, space is either vertical or horizontal depending on the current direction of auto layout (determined by below and across words).
A PAD used in a BELOW:}
return tooltip {below
text "Pad"
pad 40
text "Below"} [lancia { view layout [ 
below
text "Pad"
pad 40
text "Below"]}]


return text "and a PAD used in an across:"
return tooltip {across
text "Pad"
pad 40
text "Across"} [lancia { view layout [ 
across
text "Pad"
pad 40
text "Across"]}]

return text "Note that negative pad values are also allowed."
return tooltip {text "Bar above"
pad 20x-30
box 50x3 maroon}[lancia { view layout [ 
text "Bar above"
pad 20x-30
box 50x3 maroon]}]


return text bold "Indent"
return text {INDENT inserts spacing horizontally between the current position and the next face. It is not affected by the auto layout direction.
This example indents 20 pixels for every face after the heading:}
return tooltip {vh1 "About VID"
indent 20
text "This section is about VID."
button "Ok"
button "Cancel"}[lancia { view layout [ 
vh1 "About VID"
indent 20
text "This section is about VID."
button "Ok"
button "Cancel"]}]

return text "Negative values can also be used:"
return tooltip {vh1 "About VID"
indent 20
text "This section is about VID."
indent -20
button "Ok"
button "Cancel"}[lancia { view layout [ 
vh1 "About VID"
indent 20
text "This section is about VID."
indent -20
button "Ok"
button "Cancel"]}]

return heading "Aligning Faces"
return label "At"
return text {AT sets an absolute layout position for the face that follows it. Here's a simple example that sets the next position of a layout:}
return tooltip {at 60x30
vh2 "Simple Example"}[lancia { view layout [ 
at 60x30
vh2 "Simple Example"]}]

return text "Here is an example that places multiple faces on top of each other:"
return tooltip {at 0x0
backdrop effect [gradient 0x1 gray]
at 70x70
box effect [gradient 1x1]
at 50x50
box effect [gradient 1x1 200.0.0 0.0.100]
at 30x30
vtext bold italic 100 {This is an example of locating
   two faces using absolute positioning.}
at 20x160
button 40 "OK"}[lancia { view layout [ 
at 0x0
backdrop effect [gradient 0x1 gray]
at 70x70
box effect [gradient 1x1]
at 50x50
box effect [gradient 1x1 200.0.0 0.0.100]
at 30x30
vtext bold italic 100 {This is an example of locating
   two faces using absolute positioning.}
at 20x160
button 40 "OK"]}]

return label "Tabs"
return text {TABS specifies the tab spacing that is used when a TAB word is encountered. The direction of the tab (horizontally or vertically) depends on the current direction of the layout as specified by BELOW and ACROSS.
To set the tab spacing an integer provides regular spacing of that amount:}
return tooltip {across
tabs 150
vh3 "Buttons:"
tab
button "Button 1"
tab
button "Button 2"} [lancia { view layout [ 
across
tabs 150
vh3 "Buttons:"
tab
button "Button 1"
tab
button "Button 2"]}]

return text "Fixed tab positions can also be provided with a block of integers. In this example two tab-stops are defined to align the result:"
return tooltip {across
tabs [80 200]
h2 "Line 1"
tab field 100
tab field 100
return
h3 "Line 2"
tab check
text "Check"
tab button "Ok"
return
h4 "Line 3"
tab button "Button 1"
tab button "Button 2"}[lancia { view layout [ 
across
tabs [80 200]
h2 "Line 1"
tab field 100
tab field 100
return
h3 "Line 2"
tab check
text "Check"
tab button "Ok"
return
h4 "Line 3"
tab button "Button 1"
tab button "Button 2"]}]

return text "Note that tabs also apply vertically and tabs can be changed at any time in a layout. For example:"
return tooltip {tabs 40
field "Field 1"
field "Field 2"
field "Field 3"
return
across
tabs 100
button "Button 1"
button "Button 2"
button "Button 3"} [lancia { view layout [ 
tabs 40
field "Field 1"
field "Field 2"
field "Field 3"
return
across
tabs 100
button "Button 1"
button "Button 2"
button "Button 3"]}]

return label "Tab"
return text {TAB skips forward in the current direction (across or below) to the next tab position. Tabs positions are set with the TABS keyword. See the TABS description for more examples
The example:}
return tooltip {across
tabs 80
text "Name"  tab field return
text "Email" tab field return
text "Phone" tab field return}[lancia { view layout [ 
across
tabs 80
text "Name"  tab field return
text "Email" tab field return
text "Phone" tab field return]}]

return label "Guide"
return text {GUIDE sets the return margin for face layout. When the RETURN word is used, an invisible guide-line determines where the next face will be placed. Guides can be thought of as virtual borders that align the placement of faces. If the guide has not been set, it defaults to be the origin.
A guide can be created by specifying a position, or if no position is provided, then the current position will be used. This example shows a heading, then creates a guide for the remaining faces:}
return tooltip {across
vh2 "Guides"
guide 60x100
label "Name:" 100x24 right
field
return
label "Address:" 100x24 right
field
return}[lancia { view layout [ 
across
vh2 "Guides"
guide 60x100
label "Name:" 100x24 right
field
return
label "Address:" 100x24 right
field
return]}]

return text "Here is a good example of a problem that is solved by a guide. The layout below creates an undesired effect:"
return tooltip {vh2 "Without A Guide:"
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"}[lancia { view layout [ 
vh2 "Without A Guide:"
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"]}]


return text "If a GUIDE is added after the heading:"
return tooltip {vh2 "With A Guide:"
guide
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"} [lancia { view layout [ 
vh2 "With A Guide:"
guide
button "Button 1"
button "Button 2"
return
button "Button 3"
button "Button 4"]}]


return heading "Style Definition: Custom Styles"
return  text {You can define your own styles. This is useful if you use a style with the same facets multiple times in your layout. Defining your own style will make it easier to write and easier to modify your script later.
For instance, the code:}
return tooltip  {text black 200x24 bold "This"
text black 200x24 bold "is"
text black 200x24 bold "an"
text black 200x24 bold "example"} [lancia { view layout [ 
text black 200x24 bold "This"
text black 200x24 bold "is"
text black 200x24 bold "an"
text black 200x24 bold "example"]}]

return text "would be easier to write if a new style called txt where defined:"
return tooltip {txt "This"
txt "is"
txt "an"
txt "example"}

return text {The new style can be created in two ways. Styles can be defined in a layout, or they can be created in a stylesheet and applied to a layout.}

return label "Styles in Layouts"

return text "To create a style that is defined only within a layout, use the style keyword. In this example, the txt style is created:"
return tooltip {style txt text black 200x24 bold
txt "This"
txt "is"
txt "an"
txt "example"} [lancia { view layout [ 
style txt text black 200x24 bold
txt "This"
txt "is"
txt "an"
txt "example"]}]

return text {The style word is followed by the new style name, a base style to begin with, and a set of facets that modify it. Any facets can be supplied as part of the style, including text, images, and action.
The txt style is only valid within the layout block. It can be used within the block or within any subpanels or lists created by the block. However, if you attempt to use the style outside the block an error will occur.
Any number of custom styles can be added to the layout block.}

return label "Creating Stylesheets"
return text {To create custom styles for multiple layouts, you will need to create a stylesheet with the stylize function.}
return tooltip {new-styles: stylize [
txt: text black 200x24 bold
btn: button 80x24 effect [gradient 0x1 0.80.0]
fld: field 100x24
]}

return text {Each new style is written as a set word followed by a base style and list of facets.
To use the stylesheet within a layout, include it with a styles keyword:}
return tooltip {view layout [
    styles new-styles
    txt "Text"
    btn "Button"
    fld "Field"
]}  [lancia { view layout [ 
 styles new-styles
    txt "Text"
    btn "Button"
    fld "Field"
]}]

return text {A layout can contain any number of styles from any combination of stylesheets and styles.}

return label "Style"

return text  {STYLE defines a new style that is local to the current layout. The format of the style begins with the new style name and is followed by a normal layout face specification.}

return tooltip {style blue-text text blue center 200}

return text "Once a style has been defined, it can be used just like any other style:"
return tooltip {blue-text "Blue Text Here"}  [lancia { view layout [ 
style blue-text text blue center 200
blue-text "Blue Text Here"]}]

return text "It is common to define a new button style in a layout:"
return tooltip {style btn button 80x22 leaf
btn "Test" [print "Test button pressed"]
btn "This" [print "This button pressed"]}  [lancia { view layout [ 
style btn button 80x22 leaf
btn "Test" [print "Test button pressed"]
btn "This" [print "This button pressed"]]}]

return text {Predefined styles can be redefined with the STYLE word. For example, this line will redefine the BUTTON style used within a layout:}
return tooltip {style button button green 120x30}

return text "Such changes are local to the layout and do not affect the button style used in other layouts."
return label "Styles"
return text {STYLES allows you to use a predefined stylesheet in one or more layouts. When a stylesheet is provided, those styles become available to the layout.
A stylesheet is created with the STYLIZE function. Styles are defined similar to a layout, but with the new style name appearing as a variable definition.}
return tooltip {big-styles: stylize [
btn: button 300x40 navy maroon font-size 16
fld: field 300x40 bold font-size 16 middle center
lab: text 300x32 font-size 20 center middle red black
]} 

return text "The new styles and their names are encapsulated within the stylesheet and can be used in any layout."
return tooltip {styles big-styles
lab "Enter CPU Serial Number:"
fld "#000-0000"
lab "Press to Eject CPU:"
btn "Eject Now"
btn "Cancel"}  [lancia { big-styles: stylize [
btn: button 300x40 navy maroon font-size 16
fld: field 300x40 bold font-size 16 middle center
lab: text 300x32 font-size 20 center middle red black
] 
view layout [ 
styles big-styles
lab "Enter CPU Serial Number:"
fld "#000-0000"
lab "Press to Eject CPU:"
btn "Eject Now"
btn "Cancel"]}]

return text "Any number of stylesheets can be used within a layout."
return heading "Other Keywords"
return label "Do"
return text {DO evaluates an expression during the process of making a layout.}
return tooltip {h2 "Introduction:"
do [
intro: either exists? %intro.txt [read %intro.txt]["NA"]
]
txt intro} [lancia { view layout [ 
h2 "Introduction:"
do [
intro: either exists? %intro.txt [read %intro.txt]["NA"]
]
txt intro]}]

return text "Note that the DO is only evaluated once; when the layout is created. It is not evaluated when the layout face is shown."
return heading "Variables"
return label "Position Variables"
return text {When creating a layout, you will sometimes need to know the position of a face on the page. To do this, a position variable can be set before any layout keyword.
For instance, a convenient way to get the current position is with the AT word. If you provide it with no new position, it will simply set a variable to the current position:}
return tooltip {here: at}

return text {The variable here will hold the current position.
This can be useful if you need to use a position later in your layout. You may want to lay one face on top of another. Here is an example that places text on top of a transparent box:}
return tooltip {backdrop %nyc.jpg
banner "Example"
here: at
box 200x100 effect [multiply 60]
at here + 10x10
vtext bold 200x100 - 20x20 {
   This text is on top of the smoked
   glass, regardless of how the screen
   may layout.  That is the benefit of
   using a variable to set the position.
}}  [lancia { view layout [ 
backdrop %nyc.jpg
banner "Example"
here: at
box 200x100 effect [multiply 60]
at here + 10x10
vtext bold 200x100 - 20x20 {
   This text is on top of the smoked
   glass, regardless of how the screen
   may layout.  That is the benefit of
   using a variable to set the position.
}]}]

return label "Face Variables"

return text {Some of the faces that you use in a layout will need to be changed when the page is being displayed. For instance, the action of a button may trigger a change in text or images that are displayed.
To obtain the face that was created with a style, set a variable just before the style word. For example, here the variable name will refer to the text face that is created:}
return tooltip {name: text "Merlot" 100x30}  [lancia { view layout [ name: text "Merlot" 100x30]}]

return text "At another point on the page the text can be changed with a button that modifies the face's contents:"
return tooltip {name: button "Change" [name/text: "Cabernet"  show name]} [lancia { view layout [name: button "Change" [name/text: "Cabernet"  show name]]}]

return text {When the button is pressed, the text field of the name face will be changed to "Cabernet". The show function is then used to update the face in the window so the change can be seen.}
return label "Avoiding Variable Collisions"
return text "For large scripts that have a lot of position and face variables, it may become difficult to manage all of the names and keep them from interfering with each other. A simple solution to this problem is to define pages within objects that have the required variables defined locally to the objects. For instance here is an address book form that keeps all of its variables local:"
return tooltip {make object! [
title-name: name: email: phone: none
num: 1
page1: layout [
  title-name: title "Person 1:"
  box 200x3 red
  across
  text "Name"  tab name: field return
  text "Email" tab email: field return
  text "Phone" tab phone: field return
  button "Send" [
   send luke@rebol.com [
     "Person " num newline
      name email phone newline
      ]
   num: num + 1
   title-name/text: reform [Person num]
   clear name/text
   clear email/text
   clear phone/text
   show [title-name name email phone]
        ]
    ]
]}

return text "Be sure to add any new variables to the object definition."
return heading "Layout Dialect Keywords"
return label "Layout Organization"

return text {As described in previous documents (soon), the layout dialect consists of:
-Layout keywords that describe face positioning and other layout attributes (see below).
-Face styles that are used to specify the faces that are displayed. These can be predefined styles (see Predefined Styles document) or custom styles.
-Variable definitions that hold either faces or layout positions. These variables can be used later to access face objects or to affect face positions.
-New style definitions that are to be used within the layout. Single styles or entire stylesheets can be provided.

This document will describe the layout keywords.

Note that all layout keywords are optional and most keywords can be used multiple times.}

return label "Layout Attributes"

return text {These words control the layout as it is being created. They affect the placement of faces within the layout.}
return label "Offset"
return text {OFFSET specifies the position of the layout face within its parent face (often the screen). (NA prior to Link 0.4.35)}
return tooltip {offset 10x32}
return text {The offset need not be specified in the layout. It can be specified in the View if necessary. The default offset is 25x25.}
return label "Size"
return text {SIZE sets the size of the layout face. This must be done at the beginning of a layout before any styles are used.}
return tooltip {size 800x600}
return text {If no size is specified, then the layout is auto-sized based on the styles used within it.}
return label "Origin"
return text {ORIGIN sets the starting position of faces in the layout. The origin is specified as the number of pixels from the upper left corner of the layout window. The default origin is 20x20.}
return tooltip {origin 100x100
text "Origin at 100x100"}
return text {If an integer is specified, then both the X and Y positions will be set to that value:}
return tooltip {origin 100
text "Origin at 100x100"}
return text {The origin can also be used within a layout to return the layout to the origin position.}
return tooltip {origin
text "Back at the origin"}
return text {The origin value also determines the amount of spacing between the last face and the bottom right of the layout.
Setting the origin is especially important when creating panels and lists. Frequently the origin in lists is set to zero:}
return tooltip {list 400x80 [
    origin 0
    across
    txt 100
    txt 200
] data [
    ["Bobbie" "Smith"]
    ["Barbie" "Jones"]
    ["Bettie" "Rebol"]
]} [lancia { view layout [
list 400x80 [
    origin 0
    across
    txt 100
    txt 200
] data [
    ["Bobbie" "Smith"]
    ["Barbie" "Jones"]
    ["Bettie" "Rebol"]
]]}]

return heading "Facets"
return text {Facets are attributes of a face. Facets include the face's location, size, color, image, font, style, paragraph format, rendering effects, behavior functions, and other details. Some facets are objects themselves, allowing the sharing of attributes several faces.}
return label "View Facets"
return text {These are the primary facets used by the View display system to show faces. These facets can be inherited from the SYSTEM/view/face object which is also defined globally as the FACE object.

-offset	An X-Y PAIR that specifies the horizontal and vertical position of the face. If a face is outside it's parent face it will be clipped. Defaults to 0x0.
-size	An X-Y PAIR that specifies the width and height of the face. Defaults to 100x100.
-span	An optional X-Y PAIR that specify the range of a virtual coordinate system to use for the face. This can be used to create resolution independent displays. Normally this is set to NONE.
-pane	A face or block of sub-faces that are to be displayed within the face. This allows you to create faces that contain faces to any degree.
-text	The text contents of a face. The attributes of the text are determined by the FONT and PARA facets. Any printable value can be used.
-data	Used by VID for storing other information about the face. Outside of VID this field can be freely used by programs.
-color	The color of the face, specified as a TUPLE. When set to NONE the face is transparent. Default value is 128.128.128.
-image	An IMAGE to use for the face's body. This must be an IMAGE value not a file name. A wide range of image processing effects can be performed on the image with the EFFECT field.
-effect	A WORD or BLOCK that renders image processing effects on the face image or background. More than one effect can be used at the same time.
-edge	An OBJECT that specifies the edge of the face. It can include the color, size, and effects used for the edge.
-font	An OBJECT that specifies the font used for the text. This includes the font name, style, size, color, offset, space, align, and other attributes.
-para	An OBJECT that describes the paragraph characteristics of the text. It includes the origin, margin, indent, tabs, edit, wrap, and scrolling attributes.
-feel	An OBJECT that holds the functions that define the behavior of the face. These functions are evaluated during the rendering, selection, and hovering over a face and during events related to the face.
-rate	An INTEGER or TIME that specifies the rate of time events for a face. This is used for animation or repetitive events (such as holding the mouse down on certain types of user interface styles). An INTEGER indicates the number of events per second. A TIME provides the period between events.
-options	A BLOCK of optional flags for the face. These are normally used by a top-level view face. Options include NO-TITLE, RESIZE, NO-BORDER, ALL-OVER.
-saved-area	Enables faster rendering for transparent faces. When a face is transparent on a static (unchanging) backdrop, this field can be set to TRUE to accelerate redrawing. The face can change without requiring the backdrop to be rendered each time. The pixels for the area under the face will be saved into this field, changing it from a TRUE to an IMAGE. This field defaults to NONE.
-line-list	A BLOCK that is used to track the offsets of text lines when text is being displayed. When more than 200 characters of text are being displayed, this list should be set to NONE when large changes are made to the text. This allows REBOL to recalculate the locations of all TEXT lines.}

return heading "VID Extensions"

return text {VID extends the face definition to include these additional facets. Faces that are created with the LAYOUT or MAKE-FACE functions will include these facets in addition to those described above.
-colors	A BLOCK of alternate colors used for the face. For example, this field would hold the colors for a button that changes colors on being selected.
-texts	A BLOCK of alternate text used for the face. For example, buttons that display different text on selection would store that text here.
-effects	A BLOCK of alternate effects used for a face. For example, a BUTTON style may use a different effect when it is in the down position.
-action	A BLOCK or FUNCTION that is evaluated when the face has been selected. The type of event that triggers this action depends on the style of the face.
-alt-action	An alternate BLOCK or FUNCTION that is evaluated on an alternate selection of the face.
-keycode	A CHAR or BLOCK of shortcut keys for the face. When pressed, these keys will evaluate the ACTION field.
-state	The event state of buttons. Indicates that the button is still being pressed.
-dirty?	A LOGIC flag that indicates that the text of the face has been modified. Whenever editing is performed upon a text face, this flag will be set to TRUE.
-help	An optional string that can be used for displaying information about a button or other type of GUI element. For example, when the mouse pointer hovers over a face, this string can be displayed as help information.
-file	The FILE path or URL of the image file used for the face. The image file is automatically loaded and cached by VID.
-style	The style WORD that was used to create the face. For example: BUTTON, FIELD, IMAGE, RADIO, etc.
-user-data	A field that is available to programs for storing data related to the face. This field is not used by the VID system.}

return label "Edge Facet"

return text {The EDGE facet is an object that describes a rectangular frame that borders a face. It is used for creating image frames, button edges, table cell dividers, and other border effects. An edge is specified as an sub-object within the face object.
An EDGE object contains these fields:
-color	The color of the edge specified as a TUPLE.
-size	An X-Y PAIR that specifies the thickness of the edge. The x value refers to the thickness of the vertical edges on the left and right, and the Y value refers to the horizontal edges at the top and bottom.
-effect	A WORD or BLOCK that describes the effect to use for the edge. Edge effects include BEVEL, IBEVEL, BEZEL, IBEZEL, and NUBS.}

return label "Font Facet"

return text {The FONT facet is an object that describes the attributes of the text to be used within a face. The font is specified as an sub-object within the face object.
The FONT object contains these fields:
-name	The name of the font to use for the text. There are three predefined variables for machine independent fonts that have a similar appearance: font-serif (times-like), font-sans-serif (helvetica-like), and font-fixed (courier fixed width). To create machine independent programs, avoid specifying custom fonts. The default is font-sans-serif.
-size	An INTEGER that specifies the point size of the font. The default size is 12.
-style	A WORD or BLOCK of words that describe the style of the text. Choices are: BOLD, ITALIC, and UNDERLINE. When set to NONE no styles are used (default).
-color	A TUPLE that specifies the color of the text. The default color is black (0.0.0).
-align	A WORD that provides the alignment of the text within the face. Choices are: LEFT, RIGHT, and CENTER.
-valign	A WORD that indicates the vertical alignment of the text within the face. Choices are: TOP, BOTTOM, and MIDDLE.
-offset	A PAIR that specifies the offset of the text from the upper left corner of the face. The PARA facet object also has an effect on this offset. Default is 2x2.
-space	A PAIR that specifies the spacing between characters and between lines. The x value affects the spacing between characters. The y value changes the spacing between lines. Positive values expand the text, negative values condense it. The default is 0x0.
-shadow	A PAIR that specifies the direction and offset of the drop shadow to use for the text. Positive values project a shadow toward the lower right corner. Negative values project toward the upper left. The default is NONE.}

return label "Para Facet"

return text {The PARA facet is an object that controls the formatting of text paragraphs within the face. A para is specified as a sub-object within a face object.
The PARA object contains these fields:
-origin	An X-Y PAIR that specifies the offset of the text from the upper left corner of a face. The default is 2x2.
-margin	An X-Y PAIR that specifies the right-most and bottom limits of text display within the face. The position is relative to the bottom right corner of the face. The default is 2x2.
-indent	An X-Y PAIR that specifies the offset of a the first line of a paragraph. The X value specifies the indentation used for the first line of the paragraph. Positive and negative values may be used. The Y value specifies the spacing between the end of the previous paragraph and the first line of the next paragraph. The Y value has no affect on the first paragraph. The default is 0x0.
-scroll	An X-Y PAIR used for horizontal and vertical scrolling of text within a face. The scroll amount that modifies the offset of the text relative to the face. The origin and margin values are not affected. The default is 0x0.
-tabs	An INTEGER or BLOCK of integers that provide the tab spacing used within a paragraph. An INTEGER value indicates a fixed tab size spaced at regular intervals across the text. A BLOCK of integers provides the precise horizontal offset positions of each TAB in order. The default is 40.
-wrap?	A LOGIC value that indicates that automatic line wrapping should occur. When set to TRUE, text that exceeds the margin will be automatically wrapped to the origin. When set to FALSE, text will not be wrapped.}
return label "Feel Facet"

return text {The FEEL facet controls face's behavior in response system events like redraw, mouse input, and keyboard input. The fields of the feel object are all functions that are called by the View system on specific events. A summary of these functions is provided below. See the Face Feeling chapter for details.
The FEEL object contains these fields:
-engage	The primary function called for the majority of events that occur within a face. The ENGAGE function is called when the mouse pointer is over it's face and either mouse button is pressed. The function will also be called if a mouse button has been pressed and the mouse is moved over the face. In addition, the function is called when time events occur, such as for animation or repetitive selection events.
-over	This function is called when the mouse pointer passes over the face and no buttons are pressed. This allows code to capture hover events and provide user feedback by changing the appearance of the face. For example, hot text may change the color of the text as the mouse passes over it. This field is separate from ENGAGE because it is not used for most faces. Over actions can occur at a high frequency, so setting the OVER field to NONE allows the system to ignore it.
-detect	This function is called each time any event passes through a face. This function can be used to process events that are directed toward any subface of the face. For example, the function is used by VID to process keyboard shortcuts. The DETECT function is normally used at the window face or screen face level. Note that the insert-event-func function should be used to trap screen-face global events.
-redraw	This function is called immediately before a face is displayed. Defining this function allows a face to dynamically modify any of its facets prior to being displayed. When not being used, it is critical that this function be set to NONE to speed up the display.}
return label "Effect Facet"
return text {The EFFECT facet can be set to a WORD or a BLOCK that describes image processing operations to be performed on the backdrop of a face. When a block is used, multiple effects can be specified, and they are applied in the order in which they appear within the block. A wide range of hundreds of effects can be produced.
-fit	Scales an image to the size of the face, less the edge of the face if it exists. The image will be scaled both horizontally and vertically to fit within the face.
-aspect	Similar to FIT, but preserves the perspective of the image. The image is not distorted. If the image does not span the entire face, the remaining portion will be filled with the face background color.
-extend	Extends an image horizontally, vertically, or both. An image is stretched without affecting its scale. For instance, a button with rounded ends can be resized without affecting the dimensions of the rounded ends. This allows a single button bitmap to be reused over a wide variety of sizes. Two PAIRs are supplied as arguments. The first PAIR specifies the offset where the image should be extended. It can be horizontal, vertical, or both. The second PAIR specifies the number of pixels to extend in either or both directions.
-tile	Repeats the image over the entire face. This allows you to apply textures that span an entire face. The tile offset will be relative to the face.
-tile-view	Similar to TILE, but the tile offset will be relative to the window face.
-clip	Clips an image to the size of the face. This is normally done when the image is larger than the face, and the remaining effects do not need to be performed on the entire bitmap. The CLIP can be done at anytime in the effect block. For instance a CLIP done before a FLIP will produce a different result than a CLIP done after a FLIP.
-crop	Extracts a portion of an image. This effect takes two PAIRs: the offset into the image and the size of the area needed. This operation can be used to pick any part of an image to be displayed separately. It allows you to pan and zoom on images.
-flip	Flips an image vertically, horizontally, or both. A PAIR is provided as an argument to specify the direction of the flip. The X specifies horizontal and the Y specifies vertical.
-rotate	Rotates an image. An INTEGER specifies the number of degrees to rotate in the clockwise direction. (Currently only 0, 90, 180, and 270 degree rotations are supported.)
-reflect	Reflects an image vertically, horizontally, or both. A PAIR is used to indicate the direction of reflection. The X value will reflect horizontally, and the Y value will reflect vertically. Negative and positive values specify which portion of the image is reflected.
-invert	Inverts the RGB values of an image. (Inversion is in the RGB color space.)
-luma	  Lightens or darkens an image. An INTEGER specifies the degree of the effect. Positive values lighten the image and negative values darken the image.
-contrast	Modifies the contrast of the image. An INTEGER specifies the degree of the effect. A positive value increases the contrast and a negative value reduces the contrast.
-tint	Changes the tint of the image. An INTEGER specifies the color phase of the tint.
-grayscale	Converts a color image to black and white.
-colorize	Colors an image. A TUPLE specifies the COLOR. The image is automatically converted to grayscale before it is colorized. [???Note] in docs/view-guide.txt
-multiply	Multiplies each RGB pixel of an image to produce interesting coloration. An INTEGER, TUPLE, or IMAGE can be specified. An INTEGER will multiply each color component of each pixel by that amount. A TUPLE will multiply each of the red, green, and blue components separately. An IMAGE will multiply the red, green, and blue components of an image, allowing you to apply textures to existing images. [???Note] in docs/view-guide.txt
-difference	Computes a difference of RGB pixel values. This can be used to compare two images to detect differences between them. An IMAGE is provided as an argument. Each of its RGB pixel values will be subtracted from the face image.
-blur	Blurs an image. This effect may be used multiple times to increase the effect.
-sharpen	Sharpens an image. This effect may be used multiple times to increase the effect.
-emboss	Applies an emboss effect to the image.
-gradient	Generates a color gradient. A PAIR and two color TUPLEs can be supplied as arguments (optional). The PAIR is used to determine the direction of the gradient. The X value of one specifies horizontal and a Y value of one specifies vertical. Both X and Y can be specified at the same time, producing a gradient in both directions. Negative values reverse the gradient in that direction.
-gradcol	Colorizes an image to a gradient. Arguments are identical to GRADIENT. The image is colorized according to the colors of the gradient.
-gradmul	Multiplies an image over a gradient. Arguments are identical to GRADIENT. The image is multiplied according to the colors of the gradient.
-key	Creates a transparent image by keying. A TUPLE or INTEGER can specify a chroma or luma key effect. A TUPLE will cause all pixels of the same value to become transparent. An INTEGER will cause all pixels with lesser luma values to become transparent.
-shadow	Creates a drop shadow on a keyed image. Accepts the same arguments as KEY, but in addition to a creating transparent image it generates a 50 percent drop shadow.
-arrow	Generate an arrow image. An optional TUPLE can be used to specify the color of the arrow, otherwise the edge color will be used. The arrow is proportional to the size of the face. The direction of the arrow can be altered with FLIP or ROTATE.
-cross	Generate an X cross image. This is used for check boxes. An optional TUPLE can be used to specify the color of the cross, otherwise the edge color will be used. The cross is proportional to the size of the face.
-oval	Generate a oval image. An optional TUPLE can be used to specify the color of outside of the oval, otherwise the edge color will be used. The oval will be proportional to the size of the face.
-tab	Generate tab buttons with rounded corners. The optional arguments are: a PAIR that specifies the edge to round, a TUPLE that is used as an edge color, an INTEGER that indicates the radius of the curves, and an INTEGER that controls the thickness of the edge.
-grid	Generate a two dimensional grid of lines. This is a useful backdrop for graphical layout programs. The optional arguments are: a PAIR that specifies the horizontal and vertical spacing of the grid lines, a PAIR that specifies the offset of the first lines, a PAIR that indicates the THICKNESS of the horizontal and vertical lines, and a TUPLE that provides the color of the lines.
-draw	Draws simple lines, shapes, and fills within a face. See the Draw Dialect document for detailed information.
}
]
]

;******************
;VID handler

guida_handler: auto-resize layout [
	styles rebolide-style
	across 
	h1 "How to Handle User Interface Events"
	return
	text italic bold "You can click on the examples to see the results"
	return 
	scroll-panel 400x400 [
	across
label "How to Run the Examples"

return text  "To run any of the examples that are shown below, run a text editor and create a REBOL header line such as:"
return tooltip {REBOL [Title: "Example"]}
return text  {Then simply cut the example text and paste it after this line. Save the text file and give it a name, such as example.r. Then run the file just as you would run any REBOL file.}

return label "The Feel Object and Its Functions"
return text  {Every graphical object displayed by REBOL is a FACE. The look and feel of a face is specified by the fields of the object. One field of the object defines the FEEL of the object, and specifies how the object behaves on user input and events. When you type a key on the keyboard or move and click the mouse, it is the FEEL object that determines how the action is handled.
The REBOL/View event system is quite elegant and has evolved over many years prior to release. This is how the Visual Interface Dialect (VID) is able to create a range of behaviors for dozens of user interface objects in only a couple hundred lines of code.}
return label "Feel Functions"
return text  {The entire REBOL user interface system is handled by these four functions:
-redraw [face action position]
-over [face action position]
-engage [face action event]
-detect [face event]

These functions each have a specific purpose within the user interface event system:
-redraw	is called immediately before the face is drawn, allowing you to modify certain attributes of the face before it is shown. Each time the face refreshes its look, or each time it is shown or hidden, this function is called.
-over	is called whenever the mouse pointer passes over or off of a face. This may happen at a very high rate, because a user interface may consist of hundreds of faces and the user may move the mouse over those faces a lot. That's the reason why this is a single function and is not combined with the engage function. This function should be set to NONE if it is not needed allowing the system to ignore the face as the mouse passes over it.
-engage	is called whenever an event occurs for a face. This function handles events like mouse down, up, alt-down, double-click, timers, keyboard keys and more.
-detect	is called whenever any event occurs for a face, or for any of the faces that are contained within it. This allows a face to intercept events that are aimed at lower level graphical objects.

Any face can have a FEEL object with one or more of the above functions. This allows you to handle events from any type of graphical object, including images, text, boxes, or lines.

Note that most objects of the system share feel objects. For example, BUTTON faces share a single FEEL object that specifies the operations of a button. Modifying the FEEL object of a button will modify the FEEL object of all other buttons. Sometimes this effect may not be desired. To avoid the effect you can clone the FEEL object and only modify it for the face that you need.}
return label "The Redraw Feel"
return text  {The REDRAW feel function is quite useful when you need to modify the look of a face immediately before it is drawn. Doing this can minimize the amount of code needed to produce face state effects such as highlighting or changing a graphic when the mouse clicks on a face.
The REDRAW function has the form:

redraw face action position

The arguments of the function are:
-face	The face object being redrawn.
-action	A word that indicates the action that occurred on the face: DRAW, SHOW, HIDE.
-position	The X-Y position of the face if the face is iterated. Iterated faces will be covered in another document. For now, you can ignore this argument.

Here is a very simple example that will help you understand the REDRAW function:}
return tooltip{view layout [
    the-box: box "A Box" forest feel [
        redraw: func [face act pos] [print act]
    ]
    button "Show" [show the-box]
    button "Hide" [hide the-box]
]}[lancia { view layout [the-box: box "A Box" forest feel [
        redraw: func [face act pos] [print act]
    ]
    button "Show" [show the-box]
    button "Hide" [hide the-box]
]}]

return text  {This function will print the action word that is passed each time the REDRAW function is called. When you run the example, you will see the console immediately print:

show
draw

The show occurs when the VIEW function requests that the window be displayed. Then, the draw occurs immediately before the face is rendered.

If you click on the "Show" button, you will see the same two actions occur:

show
draw

This time the show is being done on the face directly.

When you click on the "Hide" button, the output will be:

hide

There is no show, so there is no draw either.}

return label "The Over Feel"

return text  {The OVER feel function senses the mouse passing over a face. It can be used to provide visual feedback that the mouse is over an object, or it can display help information about an item when the user hovers the mouse over it.
The OVER function has the form:

over face action position

The arguments to the OVER function are:
-face	The face object under the mouse pointer.
-action	A logic value that is either TRUE or FALSE to indicate if the mouse is entering or exiting the face.
-position	The current X-Y position of the mouse.

Here is a simple example that will help you understand the OVER function:}
return tooltip{print "Displaying..."
view layout [
    box "A Box" forest feel [
        over: func [face act pos] [print [act pos]]
    ]
]} [lancia { print "Displaying..."
view layout [box "A Box" forest feel [
        over: func [face act pos] [print [act pos]]
    ]
]}]

return text  {Run this example and pass the mouse over the box. The console will open first, then the window with the box. Make sure that the window with the box is the active window and pass the mouse over the box.

As the mouse enters the box you will see the console display:

true 23x72

And, when the mouse exits the box, you will see a message such as:

false 120x73

The action argument is TRUE when the mouse is entering and it is FALSE when the mouse is exiting.

Note that first PRINT in this example is done to open the console window to display the OVER results. If this is not done, then the first time you pass the mouse over the box, the console will open. On some systems, such as Windows, the window containing the box will lose focus, and the OVER function will immedately return FALSE. You can see this happen if you remove the first PRINT line.

Here are two examples that do something when the mouse passes over the face. The first example changes the text in the box to indicate the presence of the mouse:}
return tooltip {view layout [
    box "A Box" forest feel [
        over: func [face act pos] [
            face/text: either act ["Over"]["Away"]
            show face
        ]
    ]
]}  [lancia { view layout [
    box "A Box" forest feel [
        over: func [face act pos] [
            face/text: either act ["Over"]["Away"]
            show face
        ]
    ]
]}  ]

return text  {It shows the box with the word "Over" when the mouse is over the box, or "Away" when the mouse is off the box.

Notice that the SHOW function was called to display the new text for the face.

Here's an example that changes the color of the face as the mouse passes over:}
return tooltip {view layout [
    box "A Box" forest feel [
        over: func [face act pos] [
            face/color: either act [brick][forest]
            show face
        ]
    ]
]}  [lancia { view layout [
 box "A Box" forest feel [
        over: func [face act pos] [
            face/color: either act [brick][forest]
            show face
        ]
    ]
]}]

return text  {Here's an example that shows a "help line" based on where the mouse is:}
return tooltip {view layout [
    box "Top Box" forest feel [
        over: func [face act pos] [
            helper/text: either act ["Over top box."][""]
            show helper
        ]
    ]
    box "Bottom Box" navy feel [
        over: func [face act pos] [
            helper/text: either act ["Over bottom box."][""]
            show helper
        ]
    ]
    helper: text 
]}   [lancia { view layout [
 box "Top Box" forest feel [
        over: func [face act pos] [
            helper/text: either act ["Over top box."][""]
            show helper
        ]
    ]
    box "Bottom Box" navy feel [
        over: func [face act pos] [
            helper/text: either act ["Over bottom box."][""]
            show helper
        ]
    ]
    helper: text 
]}   ]

return label "Overlapping Faces"

return text  "When faces overlap the system will inform your code as you pass from one face to another. Here is an example that shows how this occurs:"
return tooltip {print "Displaying..."
view layout [
    box "A Box" forest feel [
        over: func [face act pos] [print ["A Box:" act]]
    ]
    pad 30x-40
    box "B Box" brick feel [
        over: func [face act pos] [print ["B Box:" act]]
    ]
]}  [lancia {
print "Displaying..."
view layout [
    box "A Box" forest feel [
        over: func [face act pos] [print ["A Box:" act]]
    ]
    pad 30x-40
    box "B Box" brick feel [
        over: func [face act pos] [print ["B Box:" act]]
    ]
]}]

return text  {As the mouse passes onto the A box the console prints:

A Box: true

When the mouse moves from the A box to the B box, then the console prints:

A Box: false
B Box: true

It first indicates that the mouse is no longer over the A box, then tells you that it is over the B box.}
return label "Continuous Over Events"

return text  "It is possible to track the mouse constantly while it is over a face. To do so, you must indicate to the top level window face that you want to know about all over events that occur:"
return tooltip {print "Displaying..."
out: layout [
    box "A Box" forest feel [
        over: func [face act pos] [print [act pos]]
    ]
]
view/options out [all-over]} [lancia {
print "Displaying..."
out: layout [
    box "A Box" forest feel [
        over: func [face act pos] [print [act pos]]
    ]
]
view/options out [all-over]}]
return text  {This code will report a continuous stream of mouse positions as the mouse moves over the face. Normally this is not necessary. It can slow down the user interface. Do it only when you need to.

Also, this is not the only way to track mouse movements. Other ways will be shown in the next sections.}
return label "The Engage Feel"
return text  {The engage function is called whenever any event other than a REDRAW or an OVER occurs for a face. It handles mouse click events, keyboard input, timers, and other types of events.
The ENGAGE function has the form:

engage face action event

Where its arguments are:
-face	The face that has the event.
-action	A word that indicates the action that has occurred.
-event	The event that provides detailed information about the action.}
return label "Mouse Event Example"

return text  "Here's a short example that will print mouse events that occur on a box:"
return tooltip {view layout [
    box "A Box" forest feel [
        engage: func [face action event] [
            print action
        ]
    ]
]} [lancia {
view layout [
    box "A Box" forest feel [
        engage: func [face action event] [
            print action
        ]
    ]
]}]

return text  {Run this example and click on the box. Right click on the box. Press the mouse button down, then move the mouse as if you were dragging the box.
As you use the mouse, you will see a stream of events such as:

down
up
alt-down
alt-up
down
over
over
over
up
down
over
over
over
away
away
away
away
away
up

These events reflect the actions you peformed with the mouse. Here is a summary of the events:
-down	the main mouse button was pressed.
-up	the main mouse button was released.
-alt-down	the alternate mouse button was pressed (right button).
-alt-up	the alternate mouse button was released.
-over	the mouse was moved over the face while either button was pressed.
-away	the mouse passed off the face while the button was pressed.}
return label "Drag and Drop Example"
return text  {Using some of the above actions, here is an example that shows how to drag a face around within a window:}
return tooltip {view layout [
    size 200x200
    box 40x40 coal "Drag Box" font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [start: event/offset]
            if find [over away] action [
                face/offset: face/offset + event/offset - start
                show face
            ]
        ]
    ]
]}  [lancia {
view layout [
    size 200x200
    box 40x40 coal "Drag Box" font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [start: event/offset]
            if find [over away] action [
                face/offset: face/offset + event/offset - start
                show face
            ]
        ]
    ]
]} ]
return text  {When the mouse is clicked in the box, the offset of the mouse relative to the box is stored in the START variable. As the mouse is moved with the button down, the over and away events are sent and the new offset is added to the position of the face. The START offset is subtracted to locate the face correctly relative to the mouse pointer.
If the start position is stored within the box face, then a style can be created and multiple drag and drop boxes can be made from a single style:}
return tooltip {view layout [
    size 240x240
    style dragbox box 40x40 font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [face/data: event/offset]
            if find [over away] action [
                face/offset: face/offset + event/offset - face/data
                show face
            ]
        ]
    ]
    dragbox "Box 1" navy
    dragbox "Box 2" teal
    dragbox "Box 3" maroon
    dragbox "Box 4" gold
]} [lancia {
view layout [
    size 240x240
    style dragbox box 40x40 font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [face/data: event/offset]
            if find [over away] action [
                face/offset: face/offset + event/offset - face/data
                show face
            ]
        ]
    ]
    dragbox "Box 1" navy
    dragbox "Box 2" teal
    dragbox "Box 3" maroon
    dragbox "Box 4" gold
]} ]

return text  {You can now drag any of the four boxes around. Notice that you can drag boxes under other boxes. The DRAGBOX style is defined with the new ENGAGE function that stores the starting position in the face's data field.
To pop the current face to the top, move it to the end of the window's face pane list when the down event occurs:}
return tooltip {view layout [
    size 240x240
    style dragbox box 40x40 font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [
                face/data: event/offset
                remove find face/parent-face/pane face
                append face/parent-face/pane face
            ]
            if find [over away] action [
                face/offset: face/offset + event/offset - face/data
            ]
            show face
        ]
    ]
    dragbox "Box 1" navy
    dragbox "Box 2" teal
    dragbox "Box 3" maroon
    dragbox "Box 4" gold
]} [lancia {
view layout [
    size 240x240
    style dragbox box 40x40 font-size 11 feel [
        engage: func [face action event] [
            if action = 'down [
                face/data: event/offset
                remove find face/parent-face/pane face
                append face/parent-face/pane face
            ]
            if find [over away] action [
                face/offset: face/offset + event/offset - face/data
            ]
            show face
        ]
    ]
    dragbox "Box 1" navy
    dragbox "Box 2" teal
    dragbox "Box 3" maroon
    dragbox "Box 4" gold
]}]

return text  "The example uses the parent-face field to access the window's pane list. You could also have assigned the window layout to a variable and used that to refer to the pane list."
return label "Keyboard Events"
return text  {To receive keyboard events, the face must be made the focus before they will be sent. Here is an example:}
return tooltip {view/new layout [
    the-box: box "A Box" forest feel [
        engage: func [face action event] [
            print [action event/key]
        ]
    ]
]
focus the-box
do-events}  [lancia {

view/new layout [
    the-box: box "A Box" forest feel [
        engage: func [face action event] [
            print [action event/key]
        ]
    ]
]
focus the-box
do-events} ]

return text  {When you type on the keyboard you will see a stream such as:

key a
key b
key c
key d

The event/key contains the keycode character for the key that was pressed.

If you press the function keys you will see:

key home
key end
key up
key down
key f1
key f5

However, these are not keycodes; they are words. In REBOL you do not need to decode the keyboard sequences. They are decoded for you. This makes it easy to write a key handler. Here is an example:}
return tooltip {view/new layout [
    the-box: box "A Box" forest feel [
        engage: func [face action event] [
            if action = 'key [
                either word? event/key [
                    print ["Special key:" event/key]
                ][
                    print ["Normal key:" mold event/key]
                ]
            ]
        ]
    ]
]
focus the-box
do-events}  [lancia {
view/new layout [
    the-box: box "A Box" forest feel [
        engage: func [face action event] [
            if action = 'key [
                either word? event/key [
                    print ["Special key:" event/key]
                ][
                    print ["Normal key:" mold event/key]
                ]
            ]
        ]
    ]
]
focus the-box
do-events}]

return text  {To detect if the control or shift keys are being held down you can write conditional tests such as:

if event/control [...]

if event/shift [...]

if event/control/shift [...]

And finally, if your system has a scroll wheel, its events will also occur as:

scroll-line

and if the control key is held down:

scroll-page

The amount of the scroll can be determined from the Y offset field of the event. Add this to one of the above examples.

if action = 'scroll-line [print event/offset/y]

The size of the Y offset is determined by the scroll-wheel sensitivity that has been set for your operating system.
Timer Events

Each face can have its own timer associated with it. When the timer expires, a TIME event will occur. Here is an example of a repeating time event that occurs every second:}
return tooltip {view layout [
    box "A Box" forest rate 1 feel [
        engage: func [face action event] [
            print action
        ]
    ]
]}  [lancia {
view layout [
    box "A Box" forest rate 1 feel [
        engage: func [face action event] [
            print action
        ]
    ]
]} ]

return text  {The rate can specify either the number of events per second or the period between events. If you used:

rate 10

then you would get ten events per second. If you wrote:

rate 0:00:10

then you would get a time event every ten seconds. Or,

rate 0:10

would send you a time event every 10 minutes.

Here is a digital clock that is based on time events:}
return tooltip {view layout [
    origin 0
    banner "00:00:00" rate 1 feel [
        engage: func [face act evt] [
            face/text: now/time
            show face
        ]
    ]
]}  [lancia {
view layout [
    origin 0
    banner "00:00:00" rate 1 feel [
        engage: func [face act evt] [
            face/text: now/time
            show face
        ]
    ]
]} ]

return text  {To create a "single shot" time event that occurs only once, you can disable the timer within the event:}
return tooltip {
ticks: 0
view layout [
    box "A Box" forest rate 0:00:10 feel [
        engage: func [face action event] [
            if action = 'time [
                if ticks > 0 [
                    face/rate: none
                    show face
                ]
                ticks: ticks + 1
                print now
            ]
        ]
    ]
]} [lancia {
ticks: 0
view layout [
    box "A Box" forest rate 0:00:10 feel [
        engage: func [face action event] [
            if action = 'time [
                if ticks > 0 [
                    face/rate: none
                    show face
                ]
                ticks: ticks + 1
                print now
            ]
        ]
    ]
]} ]

return text  {The first time event occurs immediately. (A bug in time events.) The TICKS variable keeps the count of how many times the event has occurred. To shut off the timer, the rate is set to NONE and SHOW is called on the face to update the timer internal values.}
return label "The Detect Feel"
return text  {The DETECT function is similar to ENGAGE, but has the ability to intercept events for all of its subfaces. DETECT can be used to process special events such as keyboard input, timers, or mouse events.
The DETECT function works as an event filter. When an event occurs, DETECT can decide how to handle the event. When it is done, the function can allow the event to continue to lower level faces, or stop it immediately.
DETECT should not be used if ENGAGE can deal with the event directly. DETECT is only needed when it is necessary to filter out events that are directed toward subfaces.
The DETECT function has the form:

detect face event

Where its arguments are:
-face	The face that has the event.
-event	The event that provides detailed information.

The DETECT function must return either:
-event	The same event that it was passed as an argument.
-none	When the event is not to be processed by subfaces.

Here is an example that will print every event that is received by the box face:}
return tooltip {print "Running.."
view layout [
    box 200x200 "A Box" navy feel [
        detect: func [face event] [
            print event/type
            event
        ]
    ]
]} [lancia {
print "Running.."
view layout [
    box 200x200 "A Box" navy feel [
        detect: func [face event] [
            print event/type
            event
        ]
    ]
]} ]

return text  {If the box is expanded to include a few faces within it, you can see how DETECT is used to filter events. In the example below, if you click on the "Lock Out" button, all events are locked out until you right click.}
return tooltip {lock-out: off
out: layout [
    the-box: box 240x140 teal feel [
        detect: func [face event] [
            if event/type = 'alt-down [
                lock-out: off
                vt/text: "Back to normal."
                show vt
            ]
            if not lock-out [return event]
            return none
        ]
    ]
]
out2: layout [
    space 0x8
    field "Type here"
    across
    button "Lock Out" [
        lock-out: on
        vt/text: trim/lines {Events are locked out.
            Right click to resume.}
        show vt
    ]
    button "Quit" [quit]
    return
    vt: vtext bold 200x30
]
the-box/pane: out2/pane
view out} [lancia {
lock-out: off
out: layout [
    the-box: box 240x140 teal feel [
        detect: func [face event] [
            if event/type = 'alt-down [
                lock-out: off
                vt/text: "Back to normal."
                show vt
            ]
            if not lock-out [return event]
            return none
        ]
    ]
]
out2: layout [
    space 0x8
    field "Type here"
    across
    button "Lock Out" [
        lock-out: on
        vt/text: trim/lines {Events are locked out.
            Right click to resume.}
        show vt
    ]
    button "Quit" [quit]
    return
    vt: vtext bold 200x30
]
the-box/pane: out2/pane
view out}]

return text  "Here the detect function only returns the event if the LOCK-OUT variable is set false. Otherwise it returns NONE and no events are passed down to the subfaces."
return label "Window Level Detect"
return text  {To use the DETECT function at the window level, you must set the DETECT feel function after the window VIEW has occurred, otherwise the VIEW function will override your FEEL. Here is an example:}
return tooltip {out: layout [banner "Testing"]
view/new out
out/feel: make out/feel [
    detect: func [face event] [...]
]} [lancia {
out: layout [banner "Testing"]
view/new out
out/feel: make out/feel [
    detect: func [face event] [...]
]} ]
return text  "It is better to use the INSERT-EVENT-FUNC function to set window event handlers. This function allows multiple handlers for each window. It will be discussed separately."
]]

;*********************************
;DRAW guide

guida_DRAW: auto-resize layout [
	styles rebolide-style
	across 
	h1 "The DRAW dialect"	
	return
	text italic bold "You can click on the examples to see the results"
	return 
	scroll-panel  400x400  [
across
return text  {DRAW commands are a dialect of REBOL.
DRAW blocks consist of a sequence of commands followed by arguments. DRAW commands may set attributes and modes that are used by commands that follow.
The DRAW block is not reduced, but word lookup is allowed. This is a change from prior versions of REBOL.
This change allows drawings that use the DRAW block to be embedded in messages (such as in View desktop icons, IOS conference, or AltME messages) without security concerns (because normal REBOL functions cannot be executed).
For example, this is allowed (because only words need to be evaluated):}
return tooltip {draw [pen color box offset margin]}

return text  {But this is not allowed (because block evaluation is needed):}
return tooltip {draw [pen color / 2  box offset offset + size]}

return text  {If you need that, you will need to perform REDUCE or COMPOSE yourself, prior to using the DRAW block:}
return tooltip{
reduce  ['pen color / 2  'box offset offset + size]
compose [pen (color / 2)  box offset (offset + size)]}

return label "Trying Examples"
return text  {To try any of the examples below, you can write a program as simple as this:}
return tooltip {view layout [box 400x400 black effect [draw [...]]]}
return text  {Just cut and paste the DRAW command into the ... block above. For example:}
return tooltip {view layout [box 400x400 black effect [draw [
    fill-pen 3 0x0 0 400 0 1 1 blue blue green red red
    box 0x0 400x400
]]]} [lancia {  
view layout [box 400x400 black effect [draw [
    fill-pen 3 0x0 0 400 0 1 1 blue blue green red red
    box 0x0 400x400
]]]}]
return text  "You can also create a simple test function like this:"
return tooltip {test: func [spec] [
    view layout [box 400x400 black effect [draw spec]]
]
test [fill-pen radial 0x0 0 400 0 1 1 blue green red red box]}    [lancia {  
test: func [spec] [
    view layout [box 400x400 black effect [draw spec]]
]
test [fill-pen radial 0x0 0 400 0 1 1 blue green red red box]} ]

return text  "Or add another level so you can just copy examples to the clipboard and read them automatically to run them:"

return tooltip {draw-test: does [test load read clipboard://]}    

return text  {Anywhere you specify a color, you can provide alpha channel information to control the transparency of the result. For example:}
return tooltip {pen navy fill-pen yellow
box 20x20 80x80
fill-pen 0.200.0.150
pen maroon
box 30x30 90x90}     [lancia {  view layout [box 400x400 black effect [draw [ 
                        pen navy fill-pen yellow
box 20x20 80x80
fill-pen 0.200.0.150
pen maroon
box 30x30 90x90]]]}]

return text "Or:"
return tooltip {image logo.gif 50x50 200x150 pen none line-width 0
fill-pen 200.0.0.128 box 50x50  100x150
fill-pen 0.200.0.128 box 100x50 150x150
fill-pen 0.0.200.128 box 150x50 200x150} [lancia {  view layout [box 400x400 black effect [draw [ 
image logo.gif 50x50 200x150 pen none line-width 0
fill-pen 200.0.0.128 box 50x50  100x150
fill-pen 0.200.0.128 box 100x50 150x150
fill-pen 0.0.200.128 box 150x50 200x150 
]]]}]

return  heading "Standard Commands"
return label "ANTI-ALIAS"
return text  {Turns anti-aliasing on or off; it is on by default}
return text  bold 100 {anti-alias on/off}
return text  {Notes and Examples
Compare this:}
return tooltip {anti-alias off  line-width 10  circle 200x200 100}  [lancia {  view layout [box 400x400 black effect [draw [ 
              anti-alias off  line-width 10  circle 200x200 100
     ]]]}]

return text "to this:"
     return tooltip {anti-alias on  line-width 10  circle 200x200 100}  [lancia {  view layout [box 400x400 black effect [draw [ 
              anti-alias on  line-width 10  circle 200x200 100
     ]]]}]
return text  {The ANTI-ALIAS command currently affects the entire DRAW effect; the last value you set it to is what will be used for all draw commands in the block. (TBD will be changing to keeping last setting in effect until changed)}

return label "ARC"
return text  { The ARC command draws a partial section of an ellipse (or circle).
arc  
-center [pair!]   The center of the circle
-radius [pair!]   The radius of the circle
-angle-begin [decimal!] The angle where the arc begins, in degrees
-angle-length [decimal!]  The length of the arc in degrees
-closed [word!]   Optional, must be the word closed. closed - close the arc
         
Notes and Examples
For angle-begin, 0 is to right of the center point, on the horizontal axis.
Arcs are drawn in a clockwise direction from the angle-begin point.
Simple open arcs, beginning at 0.}
return tooltip {arc 200x25  100x100 0  90
arc 200x125 100x100 0 135
arc 200x250 100x100 0 180}    [lancia {  view layout [box 400x400 black effect [draw [ 
arc 200x25  100x100 0  90
arc 200x125 100x100 0 135
arc 200x250 100x100 0 180
      ]]]}]

return text  "Simple open arcs, beginning at different angles, but all with the same length."
return tooltip {arc 200x25  100x100 0  120 
arc 200x125 100x100 45 120
arc 200x250 100x100 90 120}    [lancia {  view layout [box 400x400 black effect [draw [ 
arc 200x25  100x100 0  120 
arc 200x125 100x100 45 120
arc 200x250 100x100 90 120
     ]]]}]
     
return text  {A closed arc. The arc is closed by drawing lines to the center point of the circle that defines the arc.}
return tooltip {arc 100x100 100x100 0 90  closed
fill-pen red    arc 100x100 90x90 135 180
fill-pen green  arc 300x100 90x90 225 180
fill-pen blue   arc 100x300 90x90 45  180
fill-pen yellow arc 300x300 90x90 315 180
fill-pen red    arc 150x250 90x90 0   180
fill-pen green  arc 150x150 90x90 90  180
fill-pen blue   arc 250x150 90x90 180 180
fill-pen yellow arc 250x250 90x90 270 180}                [lancia {  view layout [box 400x400 black effect [draw [ 
                         arc 100x100 100x100 0 90  closed
fill-pen red    arc 100x100 90x90 135 180
fill-pen green  arc 300x100 90x90 225 180
fill-pen blue   arc 100x300 90x90 45  180
fill-pen yellow arc 300x300 90x90 315 180
fill-pen red    arc 150x250 90x90 0   180
fill-pen green  arc 150x150 90x90 90  180
fill-pen blue   arc 250x150 90x90 180 180
fill-pen yellow arc 250x250 90x90 270 180
	]]]}]

return text  "Closed arcs are an easy way to draw wedges for pie charts."
return tooltip {fill-pen red    arc 200x200 90x90 0   90 closed
fill-pen green  arc 200x200 90x90 90  90 closed
fill-pen blue   arc 200x200 90x90 180 90 closed
fill-pen yellow arc 200x200 90x90 270 90 closed}     [lancia {  view layout [box 400x400 black effect [draw [ 
   fill-pen red    arc 200x200 90x90 0   90 closed
fill-pen green  arc 200x200 90x90 90  90 closed
fill-pen blue   arc 200x200 90x90 180 90 closed
fill-pen yellow arc 200x200 90x90 270 90 closed
  ]]]}]

return text  "By changing the center point, you can draw exploded pie charts."
return tooltip {pen white line-width 2
fill-pen red    arc 204x204 150x150   0  90 closed
fill-pen green  arc 196x204 150x150  90  30 closed
fill-pen blue   arc 180x190 150x150 120 150 closed
fill-pen yellow arc 204x196 150x150 270  90 closed}  [lancia {  view layout [box 400x400 black effect [draw [
                  pen white line-width 2
fill-pen red    arc 204x204 150x150   0  90 closed
fill-pen green  arc 196x204 150x150  90  30 closed
fill-pen blue   arc 180x190 150x150 120 150 closed
fill-pen yellow arc 204x196 150x150 270  90 closed
    ]]]}]
    

return label "ARROW"

return text  {Set the arrow mode
arrow 
-arrow-mode [pair!] Possible numbers for combination in pair!
  0 - none
  1 - head
  2 - tail

Notes and Examples

Arrow marks are drawn at end-points, but not between the line that closes polygons, closed splines, etc.}
return tooltip {arrow 1x2  line 20x20 100x100
arrow 1x2  curve 50x50 300x50 50x300 300x300
arrow 1x2  spline 3 20x20 200x70 
150x200 50x300 80x300 200x200
arrow 1x2  spline closed 3 20x20 
200x70 150x200 50x300 80x300 200x200
arrow 1x2  polygon 20x20 200x70 150x200 50x300
arrow 1x2  box 20x20 150x200} [lancia {  view layout [box 400x400 black effect [draw [
                                       arrow 1x2  line 20x20 100x100
arrow 1x2  curve 50x50 300x50 50x300 300x300
arrow 1x2  spline 3 20x20 200x70 150x200 50x300 80x300 200x200
arrow 1x2  spline closed 3 20x20 200x70 150x200 50x300 80x300 200x200
arrow 1x2  polygon 20x20 200x70 150x200 50x300
arrow 1x2  box 20x20 150x200
 ]]]}]

return text  "Arrow is a stateful command; what you apply will be in effect until you change it again. You can reset it to no-head+no-tail with:"
return tooltip {arrow 0x0}

return label "BOX"

return text   {The BOX command provides a shortcut for a rectangular polygon. Only the upper-left and lower-right points are needed to draw the box.
box
-upper-left-point [pair!]   
-lower-right-point [pair!]
-corner-radius [decimal!]  Optional. Rounds corners

Notes and Examples

A solid fill-pen will fill the box with that color.}

return tooltip {fill-pen blue box 20x20 200x200}[lancia {  view layout [box 400x400 black effect [draw [
fill-pen blue box 20x20 200x200
      ]]]}]

return text  "An image used as the fill-pen will be repeated as the background."
return tooltip {fill-pen logo.gif  box 20x20 200x200}      [lancia {  view layout [box 400x400 black effect [draw [
fill-pen logo.gif  box 20x20 200x200
  ]]]}]

return text  "Boxes with rounded corners."
return tooltip {fill-pen blue box 20x20 380x380 30
fill-pen logo.gif  box 50x50 350x350 15} [lancia {  view layout [box 400x400 black effect [draw [
  fill-pen blue box 20x20 380x380 30
fill-pen logo.gif  box 50x50 350x350 15
   ]]]}]

return text  "line widths, patterns, joins, and rounded corners are fully supported."
return tooltip {pen red yellow
line-pattern 50 30
line-width 30
line-join round
box 50x50 350x350 
box 150x150 250x250 50} [lancia {  view layout [box 400x400 black effect [draw [
         pen red yellow
line-pattern 50 30
line-width 30
line-join round
box 50x50 350x350 
box 150x150 250x250 50
     ]]]}]

return label "CIRCLE"

return text  {Draws a circle or ellipse
circle
-center [Pair!]
-radius-x [decimal!] Used for both X and Y radii if radius-y isn't provided
-radius-y [decimal!] Optional. Used to create an ellipse
         
Notes and Examples

A simple circle}
return tooltip {pen yellow line-width 5 circle 200x200 150}   [lancia {  view layout [box 400x400 black effect [draw [ 
 pen yellow line-width 5 circle 200x200 150
   ]]]}]
 
 return text  "A circle using an image as the pen"
return tooltip {pen logo.gif circle 200x200 150}  [lancia {  view layout [box 400x400 black effect [draw [ 
  pen logo.gif circle 200x200 150
   ]]]}] 

return text  "A circle using an image as the fill-pen"
return tooltip {line-width 2 pen yellow fill-pen logo.gif
circle 200x200 150}             [lancia {  view layout [box 400x400 black effect [draw [ 
 line-width 2 pen yellow fill-pen logo.gif
circle 200x200 150
    ]]]}]

return text  "Line patterns are fully supported."
return tooltip {pen red yellow
line-pattern 50 30
line-width 30
circle 200x200 150
pen blue green
line-pattern 25 15
line-width 15
circle 200x200 125}  [lancia {  view layout [box 400x400 black effect [draw [ 
 pen red yellow
line-pattern 50 30
line-width 30
circle 200x200 150
pen blue green
line-pattern 25 15
line-width 15
circle 200x200 125
 ]]]}]

return label "CLIP"

return text  {Specifies a clipping region; drawing will only occur inside the region.
clip
-upper-left-point [pair!]   The upper-left point of the bounding box defining the clipping region.
-lower-right-point [pair!]   The lower-right point of the bounding box defining the clipping region.

Notes and Examples

The box would go to 200x200, but we clip it.}
return tooltip {line-width 2 pen yellow fill-pen blue
clip 10x10 70x90
box 20x20 200x200}  [lancia {  view layout [box 400x400 black effect [draw [ 
 line-width 2 pen yellow fill-pen blue
clip 10x10 70x90
box 20x20 200x200
   ]]]}]

return text  "Clipping other shapes can produce interesting effects."
return tooltip {pen yellow fill-pen red
clip 50x50 125x200
circle 50x50 100}   [lancia {  view layout [box 400x400 black effect [draw [
                  pen yellow fill-pen red
clip 50x50 125x200
circle 50x50 100
       ]]]}]

return text  {To turn clipping off, use none as the argument to clip.}
return tooltip {pen yellow  fill-pen red   clip 50x50 125x200
circle 50x50 100
pen green   fill-pen blue  clip none
circle 125x75 50}   [lancia {  view layout [box 400x400 black effect [draw [
                      pen yellow  fill-pen red   clip 50x50 125x200
circle 50x50 100
pen green   fill-pen blue  clip none
circle 125x75 50
 ]]]}]

return label "CURVE"

return text  {Draws a smooth Bezier curve to fit the points provided.
curve 
-point1 [pair!] End point A
-point2 [pair!] Control point A
-point3 [pair!] End point B, or control point B
-point4 [pair!] End point B

Notes and Examples

Either three or four points should be specified. With three points, it is a cubic Bezier curve with two endpoints and one control point. With four points it allows two control points, and it can create more complicated curves such as circular and elliptical arcs.
A curve with one control point}
return tooltip {curve 20x150 60x250 200x50}  [lancia {  view layout [box 400x400 black effect [draw [
    curve 20x150 60x250 200x50
  ]]]}]   

return text  "A curve with two control points"
return tooltip {curve 20x20 80x300 140x20 200x300} [lancia {  view layout [box 400x400 black effect [draw [
   curve 20x20 80x300 140x20 200x300
 ]]]}]     

return text 10 "A thick curve with a patterened line"
return tooltip {pen yellow red line-pattern 5 5 line-width 4
curve 20x150 60x250 200x50
pen yellow red line-pattern 5 5 line-width 4 fill-pen blue
curve 20x20 80x300 140x20 200x300}   [lancia {  view layout [box 400x400 black effect [draw [
       pen yellow red line-pattern 5 5 line-width 4
curve 20x150 60x250 200x50
pen yellow red line-pattern 5 5 line-width 4 fill-pen blue
curve 20x20 80x300 140x20 200x300
     ]]]}]   
return label "ELLIPSE"
return text  {Draws an ellipse
ellipse
-center [pair!] The center of the ellipse
-radius [pair!] X and Y radius is specified by a pair! which is different than the CIRCLE command

Notes and Examples

Three overlapping ellipses}
return tooltip {fill-pen red   ellipse 100x125 50x100
fill-pen white ellipse 200x200 100x100
fill-pen blue  ellipse 275x300 100x50} [lancia {  view layout [box 400x400 black effect [draw [
fill-pen red   ellipse 100x125 50x100
fill-pen white ellipse 200x200 100x100
fill-pen blue  ellipse 275x300 100x50
 ]]]}]   

return label "FILL-PEN"
return text  {Sets the color for area filling. The fill-pen color will remain in effect until it is set again.
fill-pen
-color [tuple!] 
-grad-mode [word!] The gradient style: radial/conic/diamond/linear/diagonal/cubic
-grad-offset [pair!]
-grad-start-rng [decimal!]
-grad-stop-rng [decimal!]
-grad-angle [decimal!]
-grad-scale-x [decimal!]
-grad-scale-y [decimal!]
-grad-color1 [tuple!]
-grad-color2 [tuple!]
-grad-color3 [tuple!]
-... and so on... Any number of colors may be used.
-image [image!]  Fill pattern

Notes and Examples

PENDING! We need a LOT more docs on this, particularly with regard to gradient fills.}
return tooltip {fill-pen blue}
return text  "The fill-pen can also be used to set a gradient fill pattern with any number of colors."
return tooltip {fill-pen radial 200x200 0 100 0 1 1 blue green red yellow
box 0x0 400x400
fill-pen radial 200x200 0 100 0 1 1 blue green red yellow
box 0x0 400x400
fill-pen radial 200x200 0 200 0 1 1 blue green red yellow
box 0x0 400x400
fill-pen radial 200x200 0 300 0 1 1 blue green red yellow
box 0x0 400x400 
fill-pen radial 200x200 0 400 0 1 1 blue green red yellow
box 0x0 400x400
fill-pen linear 0x0 0 300 25 1 1 red yellow green cyan blue magenta
box 100x100 300x300} [lancia {  view layout [box 400x400 black effect [draw [
fill-pen radial 200x200 0 100 0 1 1 blue green red yellow  box 0x0 400x400 ]]]
view layout [box 400x400 black effect [draw [
fill-pen radial 200x200 0 200 0 1 1 blue green red yellow  box 0x0 400x400 ]]]
view layout [box 400x400 black effect [draw [
fill-pen radial 200x200 0 300 0 1 1 blue green red yellow  box 0x0 400x400 ]]]
view layout [box 400x400 black effect [draw [
fill-pen radial 200x200 0 400 0 1 1 blue green red yellow  box 0x0 400x400 ]]]
view layout [box 400x400 black effect [draw [
fill-pen linear 0x0 0 300 25 1 1 red yellow green cyan blue magenta
box 100x100 300x300 ]]]
} ]

return text  {To clear the fill-pen, set it to none.}
return tooltip {fill-pen blue  box 100x100 200x200
fill-pen none  box 200x200 350x350
fill-pen radial 200x200 0 50 0 1 1 
0.32.200 0.92.250 0.128.255 0.64.225 
box 0x0 400x400}[lancia {  view layout [box 400x400 effect [draw [
fill-pen blue  box 100x100 200x200
fill-pen none  box 200x200 350x350
fill-pen radial 200x200 0 50 0 1 1 0.32.200 0.92.250 0.128.255 0.64.225 
box 0x0 400x400 ]]]}]

return label "FILL-RULE"
return text  {Determines the algorithm used to determine what area to fill, if a path that intersects itself or one subpath encloses another. For non-intersecting paths, you shouldn't need to use this.
fill-rule
-mode [word!] Fill algorithm:
   non-zero - This rule determines the "insideness" of a point on the canvas by drawing a ray from that point to infinity in any direction and then examining the places where a segment of the shape crosses the ray. Starting with a count of zero, add one each time a path segment crosses the ray from left to right and subtract one each time a path segment crosses the ray from right to left. After counting the crossings, if the result is zero then the point is outside the path. Otherwise, it is inside.
   even-odd - This rule determines the "insideness" of a point on the canvas by drawing a ray from that point to infinity in any direction and counting the number of path segments from the given shape that the ray crosses. If this number is odd, the point is inside; if even, the point is outside.

Notes and Examples

The following page has drawings that drawing illustrates the rules:}
return link "http://www.w3.org/TR/SVG/painting.html#FillProperties"

return label "FONT"
return text  {Sets the current font used for drawing text.
font 
-font-object [object!]

Notes and Examples

To use fonts, you create them outside the draw block, then reference them. For security reasons, the draw dialect doesn't allow evaluation, but it does allow word lookup; that's how fonts can be referenced.}
return tooltip {font-A: make face/font [style: 'bold size: 16]
font-B: make face/font [style: [bold italic] size: 20]
font-C: make face/font [style: [bold italic underline] size: 24]}
return text  {The font setting stays in effect until it is set to another value. You can't reset the font by setting it to none, but you can set it to the REBOL face/font value.}
return tooltip {text "Default font" 50x75
font font-A text "16 pt, bold" 50x125
font font-B text "20 pt, bold italic" 50x175
font font-C text "24 pt, bold italic underline" 50x225
font face/font text "face/font" 50x275} [lancia {  
font-A: make face/font [style: 'bold size: 16]
font-B: make face/font [style: [bold italic] size: 20]
font-C: make face/font [style: [bold italic underline] size: 24]
view layout [box 400x400 effect [draw [text "Default font" 50x75
font font-A text "16 pt, bold" 50x125
font font-B text "20 pt, bold italic" 50x175
font font-C text "24 pt, bold italic underline" 50x225
font face/font text "face/font" 50x275 
]]]}]

return label "GAMMA"
return text  {Sets the gamma correction value. Useful for antialiased graphics.
gamma
-gamma-value [decimal!]

Notes and Examples}

return link "http://www.poynton.com/notes/Timo/index.html"
return label "INVERT-MATRIX"
return text  {Applies an algebraic matrix inversion operation on the current transformation matrix.}
return label "IMAGE"
return text  {Draws an image, with optional scaling, borders, and color keying.
image 
-image [image!]
-upper-left-point [pair!] Optional
-upper-right-point [pair!] Optional; this is the lower-right point if only two points are provided
-lower-left-point [pair!] Optional
-lower-right-point [pair!] Optional
-key-color [tuple!] Optional; color to be rendered as transparent
-border [word!] Optional; must be the word 'border

Notes and Examples

A normal image:}
return tooltip {image logo.gif}  [lancia {  view layout [box 400x400  effect [draw [
image logo.gif
]]]}]
return text  {An image at a specific location:}
return tooltip {image logo.gif 100x100} [lancia {  view layout [box 400x400 effect [draw [
image logo.gif 100x100
]]]}]

return text  {An scaled image at a specific location:}
return tooltip {image logo.gif 100x100 300x200} [lancia {  view layout [box 400x400 effect [draw [
image logo.gif 100x100 300x200
]]]}]

return text  {An image with a border using line attributes.}
return tooltip {pen yellow red line-width 5 line-pattern 5 5
image logo.gif 100x100 border}  [lancia {  view layout [box 400x400 effect [draw [
pen yellow red line-width 5 line-pattern 5 5
image logo.gif 100x100 border
]]]}]

return text  {An image with a patterened border and a key color.}
return tooltip {pen yellow red line-width 5 line-pattern 5 5
image logo.gif 100x100 254.254.254 border} [lancia {  view layout [box 400x400 effect [draw [
pen yellow red line-width 5 line-pattern 5 5
image logo.gif 100x100 254.254.254 border
]]]}]

return text  {If you provide four points, the image will be scaled to fit those positions. This can be use to create perspective images or other simple distortions:}
return tooltip {image logo.gif 50x100 400x00 400x400 50x200
image logo.gif 10x10 350x200 250x300 50x300}  [lancia {  view layout [box 400x400 effect [draw [
image logo.gif 50x100 400x00 400x400 50x200
image logo.gif 10x10 350x200 250x300 50x300
]]]}]

return label "IMAGE-FILTER"
return text  {Specifies type of algorithm used when an image is transformed.
image-filter 
-filter-type [word!] Filter algorithm:
   nearest  Uses 'nearest neighbour' algorithm to scale image
   bilinear   Uses 'bilinear filtering' for scaling}
       
return label "LINE"
return text  {The line command draws a line between two points using the current pen, line-width, and line-pattern (if it is set).
line 
-point1 [pair!]
-point2 [pair!]
-point3 [pair!]
-...  and so on...         

Notes and Examples}
return tooltip {line 10x10 100x50} [lancia {  view layout [box 400x400 effect [draw [
line 10x10 100x50
]]]}]

return text  {If more than two points are given multiple lines are drawn in a connected fashion:}
return tooltip {line 10x10 20x50 30x0 4x40}  [lancia {  view layout [box 400x400 effect [draw [
line 10x10 20x50 30x0 4x40
]]]}]

return text  {Note that the end point is not connected to the first point. To do that, see the polygon command.
An example using pens and line attributes:}
return tooltip {pen yellow red line-width 8 line-pattern 5 5
line 10x10 20x50 30x0 4x40
pen yellow  line-width 5  line-cap round
line 100x100 100x200 200X100 200X200}  [lancia {  view layout [box 400x400 effect [draw [
pen yellow red line-width 8 line-pattern 5 5
line 10x10 20x50 30x0 4x40
pen yellow  line-width 5  line-cap round
line 100x100 100x200 200X100 200X200
]]]}]

return label "LINE-CAP"
return text  {Sets the style that will be used when drawing the ends of lines.
line-cap 
-mode [word!] Cap style: butt/square/round

Notes and Examples}
return tooltip {line-width 15
line-cap butt
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20}  [lancia {  view layout [box 400x400 effect [draw [
line-width 15
line-cap butt
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20
]]]}]

return tooltip {line-width 15
line-cap square
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20}  [lancia {  view layout [box 400x400 effect [draw [
line-width 15
line-cap square
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20
]]]}]

return tooltip {line-width 15
line-cap round
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20}  [lancia {  view layout [box 400x400 effect [draw [
line-width 15
line-cap round
pen red     line 20x20 150x20
pen yellow  line 150x20 150x150
pen red     line 150x150 20x150
pen yellow  line 20x150 20x20
]]]}]

return label "LINE-JOIN"
return text  {Sets the style that will be used where lines are joined.
line-join
-mode [word!] Join style: miter/miter-bevel/round/bevel

Notes and Examples

This will show four boxes with different line-join styles, so you can compare them. The thick, patterened, line helps show how the joins work.}
return tooltip {line-pattern 130 130
pen red yellow
line-width 15
line-join miter        box 20x20 150x150
line-join miter-bevel  box 220x20 350x150
line-join round        box 22x220 150x350
line-join bevel        box 220x220 350x350}  [lancia {  view layout [box 400x400 effect [draw [
line-pattern 130 130
pen red yellow
line-width 15
line-join miter        box 20x20 150x150
line-join miter-bevel  box 220x20 350x150
line-join round        box 22x220 150x350
line-join bevel        box 220x220 350x350
]]]}]

return label "LINE-PATTERN"
return text  {Set the line pattern. The line pattern will remain in effect until it is set to a new value or reset.
line-pattern
-stroke-size [decimal!]
-dash-size [decimal!]
-stroke-size [decimal!]
-dash-size [decimal!]
-...  and so on.. 

Notes and Examples

Set it to 5 of yellow and 5 of red.}
return tooltip {pen yellow red
line-pattern 5 5}  [lancia {  view layout [box 400x400 effect [draw [
pen yellow red
line-pattern 5 5
]]]}]

return text  {To draw a dashed line, with a transparent pen, the NONE pen color must come first.}
return tooltip {pen none yellow
line-pattern 7 2}  [lancia {  view layout [box 400x400 effect [draw [
pen none yellow
line-pattern 7 2
]]]}]

return text  {To clear the current line pattern, set it to none.}
return tooltip "line-pattern none"

return text  {Complex patterns can be specified by repeating values for stroke and dash sizes}
return tooltip {pen blue red
line-pattern 7 2 4 4 3 6}
return text "Example:"
return tooltip {line-width 3
pen red yellow
line-pattern 1 5
line 10x10 390x10
;line-pattern none
line 10x20 390x20
line 10x30 390x30
line-pattern 1 4 4 4
box 10x40 390x80}  [lancia {  view layout [box 400x400 effect [draw [
line-width 3
pen red yellow
line-pattern 1 5
line 10x10 390x10
;line-pattern none
line 10x20 390x20
line 10x30 390x30
line-pattern 1 4 4 4
box 10x40 390x80
]]]}]
return tooltip {line-width 3  pen red yellow
line-pattern 1 5  line 10x10 390x10
line-pattern 4 4  line 10x20 390x20} [lancia {  view layout [box 400x400 effect [draw [
line-width 3  pen red yellow
line-pattern 1 5  line 10x10 390x10
line-pattern 4 4  line 10x20 390x20
]]]}]

return label "LINE-WIDTH"
return text  {Sets the line width.
line-width 
-width [number!]   Zero, or negative values, produce a line-width of 1

Notes and Examples}

return tooltip {line-width .5 line 10x10 20x50 30x0 4x40
line-width 3  line 50x50 70x100 80x50 25x90
line-width 15 line 150x150 200x300 300x150 125x250} [lancia {  view layout [box 400x400 effect [draw [
line-width .5 line 10x10 20x50 30x0 4x40
line-width 3  line 50x50 70x100 80x50 25x90
line-width 15 line 150x150 200x300 300x150 125x250
]]]}]

return label "MATRIX"
return text  {Premultiply the current transformation matrix with the given block.
matrix 
-matrix-setup [block!]

Notes and Examples

MATRIX [a b c d e f]

The block values are used internally for building following transformation matrix:

a c e
b d f
0 0 1

For more information about transformations see:}
return link "http://www.w3.org/TR/SVG/coords.html#EstablishingANewUserSpace"

return label "PEN"
return text  {Sets the foreground color and background color for outline rendering (line, circle, polygon, curve, box).
pen
-stroke-color [tuple!] Primary line color
-dash-color [tuple!] Used for patterned lines
-image [image!] 

Notes and Examples

The colors can include an alpha channel value for transparency. 
Setting pen to none will set the pen color to fully transparent.}
return tooltip {pen yellow  line-width 5  box 20x20 200x200
pen yellow red  line-width 5 line-pattern 20 10 box 50x50 250x250} [lancia {  view layout [box 400x400 effect [draw [
pen yellow  line-width 5  box 20x20 200x200
pen yellow red  line-width 5 line-pattern 20 10 box 50x50 250x250
]]]}]

return label "POLYGON"
return text  {The polygon command lets you draw a closed area of line segments. It is similar to the line command, but the first and last points are connected.
polygon
-point1 [pair!] 
-point2 [pair!]
-point3 [pair!]
-... and so on...         

Notes and Examples}
return tooltip {polygon 100x100 100x200 200X100 200X200} [lancia {  view layout [box 400x400 effect [draw [
polygon 100x100 100x200 200X100 200X200
]]]}]
return tooltip {pen yellow fill-pen orange
line-width 5 line-join round
polygon 100x100 100x200 200X100 200X200}  [lancia {  view layout [box 400x400 effect [draw [
pen yellow fill-pen orange
line-width 5 line-join round
polygon 100x100 100x200 200X100 200X200
]]]}]

return label "PUSH"
return text  {Stores the current matrix setup in stack
push 
-draw-block [block!]
         
Notes and Examples

The new AGG based DRAW implementation uses a transformation matrix stack for storing different matrix setups. If the PUSH command is used, the current transformation matrix is copied into the stack. You can then change the current transformation matrix inside the PUSH command block but all commands AFTER the PUSH command block will use the matrix setup stored by the PUSH command.}
return tooltip{line-width 3
pen red
transform 200x200 30 1 1 0x0
box 100x100 300x300
push [
    reset-matrix
    pen green
    box 100x100 300x300
    transform 200x200 60 1 1 0x0
    pen blue
    box 100x100 300x300
]
pen white
box 150x150 250x250}  [lancia {  view layout [box 400x400 effect [draw [
line-width 3
pen red
transform 200x200 30 1 1 0x0
box 100x100 300x300
push [
    reset-matrix
    pen green
    box 100x100 300x300
    transform 200x200 60 1 1 0x0
    pen blue
    box 100x100 300x300
]
pen white
box 150x150 250x250
]]]}]

return label "RESET-MATRIX"
return text  {Resets the current transformation matrix to its default values.
reset-matrix

Notes and Examples

The default transformation matrix is a unit matrix. That is:

1 0 0 0 1 0 0 0 1

If you make changes with scale, skew, or rotate, this is how you would reset them.}
return label "ROTATE"
return text  {Sets the clockwise rotation, in degrees, for drawing commands.
rotate 
-angle [decimal!] Reotation degrees.

Notes and Examples

Negative numbers can be used for counter-clockwise rotation.}
return tooltip {fill-pen blue box 100x100 300x300
rotate  30 fill-pen red box 100x100 300x300
rotate -60 fill-pen yellow box 100x100 300x300}  [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 100x100 300x300
rotate  30 fill-pen red box 100x100 300x300
rotate -60 fill-pen yellow box 100x100 300x300
]]]}]

return text "See also:" 
return link "http://www.w3.org/TR/SVG/coords.html#EstablishingANewUserSpace"
return label "SCALE"
return text  {Sets the scale for drawing commands.
scale
-scale-x [decimal!] 
-scale-y [decimal!]

Notes and Examples

The values given are multipliers; use values greater than one to increase the scale; use values less than one to decrease it. Negative values}
return tooltip {fill-pen blue box 100x100 200x200
scale 2  .5  fill-pen red box 100x100 200x200
reset-matrix  ; Reset the scale.
scale .5 1.5 fill-pen yellow box 100x100 200x200} [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 100x100 200x200
scale 2  .5  fill-pen red box 100x100 200x200
reset-matrix  ; Reset the scale.
scale .5 1.5 fill-pen yellow box 100x100 200x200
]]]}]


return text  "Another way to reset the scale is to use the PUSH command:"
return tooltip {fill-pen blue box 100x100 200x200
push [scale 2  .5  fill-pen red box 100x100 200x200]
scale .5 1.5 fill-pen yellow box 100x100 200x200} [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 100x100 200x200
push [scale 2  .5  fill-pen red box 100x100 200x200]
scale .5 1.5 fill-pen yellow box 100x100 200x200
]]]}]
return text "See also:"
return link "http://www.w3.org/TR/SVG/coords.html#EstablishingANewUserSpace"
return label "SHAPE"
return text  {Draws shapes using the SHAPE sub-dialect
shape
-shape-cmd-block [block!]

Notes and Examples}
return tooltip {line-width 4
pen red
shape [move 100x100 hline 50]
pen yellow
shape [move 2x2 vline 50]}[lancia {  view layout [box 400x400 effect [draw [
line-width 4
pen red
shape [move 100x100 hline 50]
pen yellow
shape [move 2x2 vline 50]
]]]}]
return tooltip {line-width 4
pen red
shape [move 100x100 hline 50 vline 50]
pen yellow line-width 4 fill-pen red shape [
    move 100x100
    arc 200x100
    line 100x100
]} [lancia {  view layout [box 400x400 effect [draw [
line-width 4
pen red
shape [move 100x100 hline 50 vline 50]
pen yellow line-width 4 fill-pen red shape [
    move 100x100
    arc 200x100
    line 100x100
]
]]]}] 

return tooltip {pen yellow line-width 4 fill-pen red shape [
    move 100x100
    arc  100 200x100 false true
    line 100x100
    move 100x200
    arc 100 200x200 true true
    line 100x200
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 fill-pen red shape [
    move 100x100
    arc  100 200x100 false true
    line 100x100
    move 100x200
    arc 100 200x200 true true
    line 100x200
]
]]]}] 

return tooltip {pen yellow line-width 4 fill-pen red shape [
    move 100x10
    'line 100x0
    'arc 0x100
    'line -100x0
    'arc 0x-100 true
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 fill-pen red shape [
    move 100x10
    'line 100x0
    'arc 0x100
    'line -100x0
    'arc 0x-100 true
]
]]]}] 

return tooltip {pen yellow fill-pen red line-width 4 shape [
    move 100x100
    line 200x100
    curve 200x150 250x100 250x150
    curve 250x200 200x250 200x300
    line 100x300
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow fill-pen red line-width 4 shape [
    move 100x100
    line 200x100
    curve 200x150 250x100 250x150
    curve 250x200 200x250 200x300
    line 100x300
]
]]]}] 

return tooltip {pen yellow fill-pen red line-width 4 shape [
    move 100x100
    hline 200
    vline 200
    hline 100
    vline 100
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow fill-pen red line-width 4 shape [
    move 100x100
    hline 200
    vline 200
    hline 100
    vline 100
]
]]]}] 

return label "SKEW"
return text  {Sets a coordintate system skewed from the original by the given number of radians (TBD will be changing to degrees).
skew
-val [decimal!]

Notes and Examples

Positive numbers skew to the right; negative numbers skew to the left.}
return tooltip {fill-pen blue box 100x100 200x200
skew .25 fill-pen red box 150x150 250x250
reset-matrix
skew -.25 fill-pen yellow box 200x200 300x300} [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 100x100 200x200
skew .25 fill-pen red box 150x150 250x250
reset-matrix
skew -.25 fill-pen yellow box 200x200 300x300
]]]}] 

return text  {Another way to reset the skew is to use the PUSH command:}
return tooltip {fill-pen blue box 100x100 200x200
push [skew .25 fill-pen red box 150x150 250x250]
skew -.25 fill-pen yellow box 200x200 300x300}  [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 100x100 200x200
push [skew .25 fill-pen red box 150x150 250x250]
skew -.25 fill-pen yellow box 200x200 300x300
]]]}] 

return text "See also:"
return link "http://www.w3.org/TR/SVG/coords.html#EstablishingANewUserSpace"

return label "SPLINE"
return text  {The spline command lets you draw a curve through any number of points. The smoothness of the curve will be determined by the segment factor that you specify.
spline
-segmentation [integer!] Optional. Number of segments between each point; default is 1.
-closed [word!] Optional. 'closed will cause the path to be closed between the start and end points.
-point1 [pair!]
-point2 [pair!]
-...  and so on.. Any number of points may be used.

Notes and Examples}
return tooltip {spline 20x20 200x70 150x200 50x230 50x300 80x300 200x200
spline 3 20x20 200x70 150x200 50x230 50x300 80x300 200x200
spline 10 closed 20x20 200x70 150x200 50x230 50x300 80x300 200x200}[lancia {  view layout [box 400x400 effect [draw [
spline 20x20 200x70 150x200 50x230 50x300 80x300 200x200
spline 3 20x20 200x70 150x200 50x230 50x300 80x300 200x200
spline 10 closed 20x20 200x70 150x200 50x230 50x300 80x300 200x200
]]]}] 

return label "TEXT"
return text  {Draws a string of text.
text
-text-string [string!]
-offset [pair!]
-render-mode [word!] How text will be rendered:
     anti-aliased
     vectorial - Can be transformed with stroke/dashes, filled with fill-pens, etc.
     aliased
         
Notes and Examples

PENDING! Do we need to discuss what Type 1 and Type 2 fonts are?

To run some of these tests, you'll need to define the following font objects:}
return tooltip {bold20: make face/font [style: 'bold size: 20]
bold32: make face/font [style: 'bold size: 32]}

return text  "Basic text isn't too exciting to look at."
return tooltip {text "This is a string of text  - Default size (12)" 50x25
text vectorial "This is a string of text 1" 50x75
text aliased "This is a string of text 2" 50x125
font bold20 text anti-aliased "Font Size 20" 50x175
font bold20 text vectorial "Font Size 20, type 1" 50x225
font bold20 text aliased "Font Size 20, type 2" 50x275} [lancia {  
bold20: make face/font [style: 'bold size: 20]
bold32: make face/font [style: 'bold size: 32]
view layout [box 400x400 effect [draw [
text "This is a string of text  - Default size (12)" 50x25
text vectorial "This is a string of text 1" 50x75
text aliased "This is a string of text 2" 50x125
font bold20 text anti-aliased "Font Size 20" 50x175
font bold20 text vectorial "Font Size 20, type 1" 50x225
font bold20 text aliased "Font Size 20, type 2" 50x275
]]]}] 


return text  "Vectorial text supports the pen, fill-pen, line-width, and line-pattern settings."
return tooltip {font bold32 pen yellow red line-pattern 5 5 line-width 2
text vectorial "Patterned Text" 50x150} [lancia {  
bold32: make face/font [style: 'bold size: 32]
view layout [box 400x400 effect [draw [
font bold32 pen yellow red line-pattern 5 5 line-width 2
text vectorial "Patterned Text" 50x150
]]]}] 
return text  "With vectorial text you can also define a spline using pairs, which is used as a path the text will follow. If only one pair is given, it acts as a normal text offset."
return tooltip {font bold32
line-width 2
pen snow
fill-pen linear 10x10 0 400 0 1 1 
0.0.255 0.0.255 0.255.0 255.0.0 255.0.0
text vectorial 20x300 150x30 250x300 
420x140 "Curved text rendered by DRAW!" 500}  [lancia {  
bold32: make face/font [style: 'bold size: 32]
view layout [box 400x400 effect [draw [
font bold32
line-width 2
pen snow
fill-pen linear 10x10 0 400 0 1 1 0.0.255 0.0.255 0.255.0 255.0.0 255.0.0
text vectorial 20x300 150x30 250x300 420x140 "Curved text rendered by DRAW!" 500
]]]}] 

return text  "You can also close the path:"
return tooltip {font bold32
line-width 2
pen snow
fill-pen 3 10x10 radial 400 0 1 1 
0.0.255 0.0.255 0.255.0 255.0.0 255.0.0
text vectorial 60x60 240x110 
190x240 90x270 
"Curved text rendered by DRAW!" 500 closed} [lancia {  
bold32: make face/font [style: 'bold size: 32]
view layout [box 400x400 effect [draw [
font bold32
line-width 2
pen snow
fill-pen 3 10x10 radial 400 0 1 1 0.0.255 0.0.255 0.255.0 255.0.0 255.0.0
text vectorial 60x60 240x110 190x240 90x270 
"Curved text rendered by DRAW!" 500 closed
]]]}] 

return label "TRANSFORM"
return text  {You can apply a transformation such as translation, scaling, and rotation to any DRAW result.
transform
-angle [decimal!]
-center [pair!]
-scale-x [decimal!]
-scale-y [decimal!]
-translation [pair!]

Notes and Examples

See also:
    Viewtop REBOL/tests/draw-matrix.r}
return link "http://www.w3.org/TR/SVG/coords.html#TransformAttribute"

return label "TRANSLATE"
return text   {Sets the origin for drawing commands.
translate 
-offset [pair!]

Notes and Examples

Multiple translate commands will have a cumulative effect:}
return tooltip {fill-pen blue box 50x50 150x150
translate 50x50 fill-pen red box 50x50 150x150
translate 50x50 fill-pen yellow box 50x50 150x150}[lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 50x50 150x150
translate 50x50 fill-pen red box 50x50 150x150
translate 50x50 fill-pen yellow box 50x50 150x150
]]]}] 

return text  "You can use RESET-MATRIX to avoid that if you want:"
return tooltip {fill-pen blue box 50x50 150x150
translate 50x50 fill-pen red box 50x50 150x150
reset-matrix
translate 50x50 fill-pen yellow box 100x100 300x300} [lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 50x50 150x150
translate 50x50 fill-pen red box 50x50 150x150
reset-matrix
translate 50x50 fill-pen yellow box 100x100 300x300
]]]}] 

return text  "Another way to reset the skew is to use the PUSH command:"
return tooltip {fill-pen blue box 50x50 150x150
push [translate 50x50 fill-pen red box 50x50 150x150]
translate 50x50 fill-pen yellow box 100x100 300x300}[lancia {  view layout [box 400x400 effect [draw [
fill-pen blue box 50x50 150x150
push [translate 50x50 fill-pen red box 50x50 150x150]
translate 50x50 fill-pen yellow box 100x100 300x300
]]]}] 
return text "See also:"
return link "http://www.w3.org/TR/SVG/coords.html#EstablishingANewUserSpace"

return label "TRIANGLE"
return text   {The TRIANGLE command provides a shortcut for a triangular polygon with optional shading parameters (Gouraud shading). The three vertices of the triangle are used to specify it.
triangle
-vertex1 [pair!]
-vertex2 [pair!]
-vertex3 [pair!]
-color1 [tuple!]
-color2 [tuple!]
-color3 [tuple!]
-dilation [decimal!] This is useful for eliminating anitaliased edges

Notes and Examples

This should make it easy to see where each triangle is:}
return tooltip {pen none
triangle 50x150  150x50  150x150 red    green  blue
triangle 150x50  250x150 150x150 green  yellow blue
triangle 250x150 150x350 150x150 yellow orange blue
triangle 150x350 50x150  150x150 orange red    blue} [lancia {  view layout [box 400x400 effect [draw [
pen none
triangle 50x150  150x50  150x150 red    green  blue
triangle 150x50  250x150 150x150 green  yellow blue
triangle 250x150 150x350 150x150 yellow orange blue
triangle 150x350 50x150  150x150 orange red    blue
]]]}] 

return text  "This gives you a much more subtle blending in the middle:"
return tooltip {pen none
triangle 50x150  150x50  150x150 red    green  gray
triangle 150x50  250x150 150x150 green  yellow gray
triangle 250x150 150x350 150x150 yellow orange gray
triangle 150x350 50x150  150x150 orange red    gray} [lancia {  view layout [box 400x400 effect [draw [
pen none
triangle 50x150  150x50  150x150 red    green  gray
triangle 150x50  250x150 150x150 green  yellow gray
triangle 250x150 150x350 150x150 yellow orange gray
triangle 150x350 50x150  150x150 orange red    gray
]]]}] 

return text  "And this shows simple highlighting/shading:"
return tooltip {pen none
triangle 50x150  150x50  150x150 water sky   sky
triangle 150x50  250x150 150x150 water coal  sky
triangle 250x150 150x350 150x150 coal  coal  sky
triangle 150x350 50x150  150x150 coal  water sky} [lancia {  view layout [box 400x400 effect [draw [
pen none
triangle 50x150  150x50  150x150 water sky   sky
triangle 150x50  250x150 150x150 water coal  sky
triangle 250x150 150x350 150x150 coal  coal  sky
triangle 150x350 50x150  150x150 coal  water sky
]]]}] 
return text  "TBD	Need docs on the order of gradient colors."
]]

;*******************
;SHAPE guide

guida_shape: auto-resize layout [
	styles rebolide-style
	across 	
	heading "REBOL/View SHAPE Developer's Guide"
	return
	text italic bold "You can click on the examples to see the results"
	return 
	scroll-panel 400x400 data [
	across
heading "SHAPE commands"
return text {The goal of the SHAPE command is to allow more complex shape descriptions (imagine a path description that describes the shape of the REBOL logo, for example). The shape commands were designed to be compatible with SVG path commands.
Look at}
return link "http://www.w3.org/TR/SVG11/paths.html"
return text {for more details.
When you use a shape command in the DRAW dialect, the argument it takes is, itself, a block of commands. These commands use a specialized SHAPE dialect, which is not the same as the DRAW dialect.

By supplying this information within a block, programs can easily delimit the path itself, and it can even be specified outside of the draw block and referenced through a variable. The use of words like move and line (rather than single characters as in SVG) is not significant in memory because they are symbols (references), and for very large files the source format can use compress and the longer names will not be a factor (compressors find those kinds of patterns easily).

The shape is closed automatically, i.e. as a polygon, unless you specify a move command at the end of the shape block.}
return label "Relative positioning"

return text {Path commands can be absolute or relative. Within SVG this is represented by character casing. However, shape avoids symbol casing issues; instead, it uses literal words for relative commands. For example:}
return tooltip {[move 100x100]  ; is absolute
['move 100x100] ; is relative
}
return text {Regarding the construction and semantic issues of such forms, because we are dealing with a pure dialect of REBOL (no direct interpretation of REBOL functions), constructing and handling such blocks is quite easy. There is also the benefit from the fact that absolute and relative commands are different datatypes, so operations that search are kept simple. e.g. find lit-word! can be used to find relative path commands.
Examples:}
return tooltip {pen yellow line-width 4 fill-pen red shape [
    move 100x175
    arc  75 200x175 false true
    line 100x175
    move 100x200
    arc 100 200x200 true true
    line 100x200
]}[lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 fill-pen red shape [
    move 100x175
    arc  75 200x175 false true
    line 100x175
    move 100x200
    arc 100 200x200 true true
    line 100x200
]
]]]}] 

return tooltip {pen yellow line-width 4 fill-pen red shape [
    move 100x100
    'line 100x0
    'arc 0x100
    'line -100x0
    'arc 0x-100 true
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 fill-pen red shape [
    move 100x100
    'line 100x0
    'arc 0x100
    'line -100x0
    'arc 0x-100 true
]
]]]}] 
return tooltip {pen yellow fill-pen red line-width 4 shape [
    move 100x100
    line 200x100
    curve 200x150 250x100 250x150
    curve 250x200 200x250 200x300
    line 100x300
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow fill-pen red line-width 4 shape [
    move 100x100
    line 200x100
    curve 200x150 250x100 250x150
    curve 250x200 200x250 200x300
    line 100x300
]
]]]}] 

return text {Converting SVG path commands to shape commands

Some people in the REBOL community are already working on this.

Here is a reference to the BNF grammar for SVG paths:}

return link "http://www.w3.org/TR/SVG11/paths.html#PathDataBNF"
return heading "Shape block commands"
return label "ARC"
return text {Draws an elliptical arc from the current point.
arc
-point1 [pair!]
-radius-x [decimal!]
-radius-y [decimal!]
-angle [decimal!]
-sweep [logic!]
-large [logic!]

Notes and Examples

LARGE and SWEEP should be keywords too

Set SWEEP to draw arcs in a "positive-angle" direction.}
return tooltip {pen yellow line-width 4 shape [
    move 100x200
    arc  75 200x200 false false
]
pen red shape [
    move 100x205
    arc 75 200x205 true false
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 shape [
    move 100x200
    arc  75 200x200 false false
]
pen red shape [
    move 100x205
    arc 75 200x205 true false
]
]]]}] 

return text "Set LARGE for arc sweeps greater than 180."
return tooltip {pen yellow line-width 4 shape [
    move 100x200
    arc  75 200x200 false true
]
pen red shape [
    move 100x205
    arc 75 200x205 true true
]} [lancia {  view layout [box 400x400 effect [draw [
pen yellow line-width 4 shape [
    move 100x200
    arc  75 200x200 false true
]
pen red shape [
    move 100x205
    arc 75 200x205 true true
]
]]]}] 

return label  "CURV"
return text {Smooth CURVE shortcut.
curv 
-point1 [pair!]
-point2 [pair!]
-point1 [pair!]
-... and so on..         

Notes and Examples

From http://www.w3.org/TR/SVG11/paths.html:

"The first control point is assumed to be the reflection of the second control point on the previous command relative to the current point. (If there is no previous curve command, the first control point is the current point.)"}

return label "CURVE"
return text {Draws a cubic Bezier curve.
curve
-point1 [pair!]
-point2 [pair!]
-point3 [pair!]
-point1 [pair!]
-... and so on...         

Notes and Examples

A cubic Bezier curve is defined by a start point, an end point, and two control points.}
return label "HLINE"
return text {Draws a horizontal line from the current point.
hline
-end-x [decimal!]

Notes and Examples

Using absolute coordinates:}
return tooltip {line-width 4
shape [
    move 100x100  hline 300
    move 100x150  hline 250
    move 100x200  hline 200
]} [lancia {  view layout [box 400x400 effect [draw [
line-width 4
shape [
    move 100x100  hline 300
    move 100x150  hline 250
    move 100x200  hline 200
]
]]]}] 

return text "Using relative coordinates:"
return tooltip {line-width 4
shape [
    move 100x100   'hline 200
    'move -200x50  'hline 150
    'move -150x50  'hline 100
]} [lancia {  view layout [box 400x400 effect [draw [
line-width 4
shape [
    move 100x100   'hline 200
    'move -200x50  'hline 150
    'move -150x50  'hline 100
]
]]]}] 

return label "LINE"
return text {Draws a line from the current point through the given points, the last of which becomes the new current point.
line
-point1 [pair!]
-point2 [pair!]
-point3 [pair!]
-point4 [pair!]
-...  and so on...         }

return label "MOVE"
return text {Set's the starting point for a new path without drawing anything.
move 
-point1 [pair!]

Notes and Examples

The effect is as if the "pen" were lifted and moved to a new location.

Used at the end of a SHAPE command, MOVE prevents the shape from being drawn as a closed polygon.}
return tooltip {line-width 4
pen red
shape [
    move 100x100
    line 20x20 150x50
    move 0x0
]
pen blue
shape [
    move 100x200
    line 20x120 150x150
]}  [lancia {  view layout [box 400x400 effect [draw [
line-width 4
pen red
shape [
    move 100x100
    line 20x20 150x50
    move 0x0
]
pen blue
shape [
    move 100x200
    line 20x120 150x150
]
]]]}] 

return text {Using relative coordinates for the second shape:}
return tooltip {line-width 4
pen red
shape [
    move 100x100
    line 20x20 150x50
    move 0x0
]
pen blue
shape [
    move 100x100
    'move 0x100
    'line -80x-80 130x30
    'move 0x0
]}  [lancia {  view layout [box 400x400 effect [draw [
line-width 4
pen red
shape [
    move 100x100
    line 20x20 150x50
    move 0x0
]
pen blue
shape [
    move 100x100
    'move 0x100
    'line -80x-80 130x30
    'move 0x0
]
]]]}] 

return label "QCURV"
return text {Smooth QCURVE shortcut.
qcurv
-point1 [pair!]

Notes and Examples

Draws a cubic Bezier curve from the current point to point1.
See CURV and:}
return link "http://www.w3.org/TR/SVG11/paths.html"

return label "QCURVE"
return text {Draws quadratic Bezier curve.
qcurve
-point1 [pair!]
-point2 [pair!]
-point1 [pair!]
-...   and so on...         

Notes and Examples

A quadratic Bezier curve is defined by a start point, an end point, and one control point.}
return label "VLINE"
return text {Draws a vertical line from the current point.
vline
-end-y [decimal!]

Notes and Examples

Using absolute coordinates:}
return tooltip {line-width 4
shape [
    move 100x100  vline 300
    move 150x100  vline 250
    move 200x100  vline 200
]}  [lancia {  view layout [box 400x400 effect [draw [
line-width 4
shape [
    move 100x100  vline 300
    move 150x100  vline 250
    move 200x100  vline 200
]
]]]}] 

return text "Using relative coordinates:"
return tooltip {line-width 4
shape [
    move 100x100   'vline 200
    'move 50x-200  'vline 150
    'move 50x-150  'vline 100
]} [lancia {  view layout [box 400x400 effect [draw [
line-width 4
shape [
    move 100x100   'vline 200
    'move 50x-200  'vline 150
    'move 50x-150  'vline 100
]
]]]}] 

]]






;****************************
;RebolCore viewer, see: parse-core23-manual.r  on www.REBOL.org


source-contents: [
    rebol-site: http://www.rebol.com/docs/core23/
    table-of-contents: read/lines http://www.rebol.com/docs/core23/rebolcore.html
    forall table-of-contents [
        if (find table-of-contents/1 "Introduction")[break]
    ] 
    source-documents: make block! 50
    foreach line table-of-contents [
        replace line "Network<BR>" "Network Protocols </SPAN>"
        if find line "A HREF" [
            parse line [thru {<A HREF="} copy part-url to {">}]
            parse line [thru <SPAN STYLE="Font-Size : 12pt"> copy doc-title to </SPAN>]
            append source-documents      doc-title
            append source-documents join rebol-site part-url
        ]
    ]
    replace source-documents (select source-documents "Changes") http://www.rebol.com/docs/changes.html
    source-documents: find source-documents "Updates"
    remove source-documents
    remove source-documents                     ;remove "Updates" format is different
    source-documents: head source-documents
    clear document-list/data

    forskip source-documents 2 [
        append document-list/data first source-documents
    ]
    show document-list
]


if not exists? %local-docs/ [make-dir %local-docs]


                 ;====   Parse & Convert Documents   ====

HTML-RTML: func [page-requested] [
    all-positions:     make block!  600
    p-tag-positions:   make block!  300
    pre-tag-positions: make block!  100
    h2-tag-positions:  make block!   50
    h3-tag-positions:  make block!   50
    image-positions:   make block!   10
    image-files:       make block!   10

    show advice


                 ;====     Parse HTML Functions      ====

    paragraphs: func [position][
        HTML: head HTML
        HTML: skip HTML position - 1
        parse HTML [thru <p> copy text-in-here to </P>]
        trim/tail text-in-here
        line-height: length? text-in-here
        if line-height < 25 [line-height: 45]          
        text-in-here: rejoin [  " p-area 490x"   (to-integer (line-height / 3) + 20) " "   mold text-in-here      newline newline ]
        append content to-block copy text-in-here
        clear text-in-here
    ]

    scripts: func [position][
        HTML: head HTML
        HTML: skip HTML position - 2
        parse HTML [thru "<pre>" copy text-in-here to "</pre>"]
        trim/tail text-in-here
        line-counter: 1
        formed-text: copy form text-in-here            ; to count newlines
        forall formed-text [if (formed-text/1 = to-char "^/") [line-counter: line-counter + 1]]
        area-y: (to-integer  line-counter * 18)
        if area-y < 30 [area-y: 30]
        text-in-here:  rejoin [" pre-area 440x" area-y " "  mold text-in-here   newline]
        append content  to-block text-in-here 
        line-counter: 1
        area-y: area-y + 40
    ]

    headings: func [position][
        HTML: head HTML
        HTML: skip HTML position - 1
        parse HTML [to "<h2" copy heading-in-here thru </h2>]
        parse HTML [thru ">" copy heading-in-here to     "<"]
        append heading-list/data copy heading-in-here
        heading-in-here: rejoin ["heading " mold heading-in-here newline]
        append content to-block copy heading-in-here
        clear heading-in-here
    ]

    sub-headings: func [position][
        HTML: head HTML
        HTML: skip HTML position - 1
        parse HTML [to "<h3" copy sub-in-here thru </h3>]
        parse HTML [thru ">" copy sub-in-here to "<"]
        append sub-heading-list/data copy sub-in-here
        sub-in-here: rejoin ["sub-heading " mold sub-in-here newline]
        append content to-block copy sub-in-here
        clear sub-in-here
    ]


   illustrations: func [position][
        HTML: head HTML
        HTML: skip HTML position - 2
        parse HTML [thru "<img src=" copy image-in-here to "></P>"]  ;breaks at "Updates" page with tables
        file: to-file form to-block image-in-here
        append image-files file
        if not exists? file [
            advice/text: "Downloading Image..."
            show advice
            write/binary file read/binary join rebol-site file
            advice/text: "Reading File...."
            hide advice
        ]
        image-in-here: rejoin ["pad 90x0 image "  "%" image-in-here  "pad -90x0" newline newline]
        append content to-block copy image-in-here
        clear image-in-here
    ]


                  ;====  Get the HTML document       ====

    HTML: read page-requested  ;read page-requested for internet, just page-requested for local
    a-scroller/data: 0
    show a-scroller
    hide advice
    content: []
    

                 ;====  Remove & Change Html Coding  ====
    
    replace/all HTML "<p></li>"  </p>   ;.....
    replace/all HTML {<span class="output">}  " "
    replace/all HTML </span>               " "
    replace/all HTML "&gt;"  "> "
    replace/all HTML "&lt;"  "<"
    replace/all HTML "<b><tt>"   "^""  ;??
    replace/all HTML "</tt></b>" "^""  ;??
    replace/all HTML <b> "^"" 
    replace/all HTML </b> "^"" 
    replace/all HTML <tt> "^"" 
    replace/all HTML </tt> "^"" 
    replace/all HTML <i> "^"" 
    replace/all HTML </i> "^"" 
    replace/all HTML </li> ""
    replace/all HTML <li>  ""
    replace/all HTML <li> <p>
    replace/all HTML </li> </p>
    replace/all HTML {<tr><td><a href="http://www.rebol.com/docs.html"><img src="http://www.rebol.com/graphics/doc-bar.gif" width="680" height="28" align="bottom" alt="rebol document" border="0" usemap="#bar-map" ismap></a></td></tr>
} ""
    replace/all html <ul> ""
    replace/all html </ul> ""
    replace/all HTML "(})."   "."                    ;closing brace issue in values page
    html-error: join "^{" "    "
    replace/all HTML html-error "    "
    replace HTML "{REBOL End User License Agreement IMPORT" "{REBOL End User License Agreement IMPORT}"
    if (find html  {<a class="toc2"}) [html: find/last html {<a class="toc2"}]



                 ;====     Find & Mark Positions     ====

    parse HTML [
        any [
            to "<p>" mark: thru "</p>"
            (append p-tag-positions index? mark)
        ]
    ]

    parse HTML [
        any [
            to "<pre" mark: thru "/pre>"
            ( append pre-tag-positions index? mark)
        ]
    ]
    parse HTML [
        any [
            to "<h2" mark: thru ">"
            (append h2-tag-positions index? mark)
        ]
    ]

    parse HTML [
        any [
            to "<h3" mark: thru ">"
            (append h3-tag-positions index? mark)
        ]
    ]


    parse HTML [
        any [
            to "<img src=" mark: thru "></p>"
            (append image-positions index? mark)
        ]
    ]

    append all-positions p-tag-positions
    append all-positions pre-tag-positions
    append all-positions h2-tag-positions
    append all-positions h3-tag-positions
    append all-positions image-positions

    sort all-positions


                  ;===     Reconstruct With Markers  ====


    foreach item all-positions [
        if find  p-tag-positions   item  [paragraphs    item]
        if find  pre-tag-positions item  [scripts       item]
        if find  h2-tag-positions  item  [headings      item]
        if find  h3-tag-positions  item  [sub-headings  item]
        if find image-positions    item  [illustrations item]
    ]


                 ;====        Start Document         ====

    rtml-page: copy rtml-template
    append rtml-page copy content
    clear content

    panel/pane: layout rtml-page
    panel/pane/offset: 0x0
    show [panel heading-list sub-heading-list]
    hide advice
]


    rtml-template: [                                 ; REBOL determines size
        backdrop linen
        style p-area   area linen  middle font-size 14 wrap with [edge/size: 0x0 para/origin: 5x3]
        style pre-area area silver font-size 14 wrap middle  with [para/origin: 40x-20]
        style heading h2 490x23 navy
        style sub-heading   h3 490x23 water
        origin 0x0
        across
        space 0
        image logo.gif
        document-header: box 450x24 coal green "Documentation"
        origin 40x40   ;can chop off the first of lines
        below
        space 0
    ]


local-file?: true



                 ;====         Main layout           ====

coremanual_main: auto-resize layout [
    backdrop with [effect: [gradient 0x1 gray 114.110.75]]
    origin 20x20
    panel: box 550x600 with [effect: [gradient 0x1  gray 181.181.132] ] 
    return
    pad -7x0
    a-scroller: scroller 16x600 [
        if not none? panel/pane [                                 ;without a layout - a scroller error
            panel/pane/offset/y: negate face/data * panel/pane/size/y
            show panel/pane
        ]
    ]
    return
    pad 0x20

    sub-heading-list: text-list 300x200 black silver data array 20 [
        all-offsets: make block! 100
        foreach pane-face panel/pane/pane [
            append all-offsets pane-face/offset/2
            if pane-face/text = face/picked/1 [
                face-place: pane-face/offset
                panel/pane/offset/y: negate face-place/2
            ]
        ]
        show panel/pane
        a-scroller/data: face-place/2 / last all-offsets
        show a-scroller
        reset-face heading-list
    ]

    heading-list:  text-list 300x100 black silver data array 20  [
        all-offsets: make block! 100
        foreach pane-face panel/pane/pane [
            append all-offsets pane-face/offset/2
            if pane-face/text = face/picked/1 [
                face-place: pane-face/offset
                panel/pane/offset/y: negate face-place/2
            ]
        ]
        show panel/pane
        a-scroller/data: face-place/2 / last all-offsets
        show a-scroller
        reset-face sub-heading-list
    ]

    document-list: text-list 300x100 black silver data array 20 [             ;...array used to set dragger
        show advice
        show face
        picked-page: select source-documents face/picked/1
        clear heading-list/data 
        clear sub-heading-list/data 

        either local-file? [            
            saved-page: load join %local-docs/ last split-path picked-page  ;saved-page
            saved-page: skip saved-page (length? rtml-template)
            while [not tail? saved-page] [
                if (saved-page/1 = 'pre-area) [replace/all saved-page/3 "r-ebol" "REBOL"]
                saved-page: next saved-page 
            ]
        saved-page: head saved-page
        panel/pane: layout rtml-page: saved-page    ;rtml-page is used for convenience of saving local files
        panel/pane/offSet: 0x0
        clear sub-heading-list/data
        clear heading-list/data
        show panel
        saved-page: skip saved-page (length? rtml-template )
        forall saved-page [
            if saved-page/1 = 'heading       [append       heading-list/data second saved-page]
            if saved-page/1 = 'sub-heading   [append   sub-heading-list/data second saved-page]
        ]
        a-scroller/data: sub-heading-list/sld/data: heading-list/sld/data: document-list/sld/data: 0
        sub-heading-list/sn: heading-list/sn: document-list/sn: 0
        reset-face heading-list
        reset-face sub-heading-list
        reset-face a-scroller
        a-scroller/show?: true
        ][         
            HTML-RTML picked-page 
        ]
        document-header/text: face/picked/1
        show document-header
        hide advice
    ]

    across
    pad 650x-180
    at 600x470
    btn "Download from Internet" [
        either connected? [
            clear heading-list/data 
            clear sub-heading-list/data
            clear document-list/data
            hide file-source
            show advice
            reset-face heading-list 
            reset-face sub-heading-list
            reset-face document-list

            do source-contents 

            hide advice
            file-source/text: "Online Files"
            show file-source
            local-file?: false
            reset-face a-scroller
            hide a-scroller 
        ][alert "No Internet"]
    ]

    btn "Save" [
        if error? try [ 
            forall rtml-page [
                if all [
                    rtml-page/1 = 'pre-area 
                    pair? rtml-page/2
                ][
                    replace/all rtml-page/3 "REBOL" "r-ebol"
                    line-counter: 1
                    formed-text: copy form rtml-page/3
                    forall formed-text [if (formed-text/1 = to-char "^/") [line-counter: line-counter + 1]]
                    area-y:  (line-counter * 18)
                    if rtml-page/2/2 < 30 [area-y: 30]
                    rtml-page/2/2: area-y
                ]
                if all  [
                    rtml-page/1 = 'p-area 
                    pair? rtml-page/2
                ][
                    text-length: length? rtml-page/3
                    if rtml-page/2/2 < 25 [rtml-page/2/2: 45] 
                    rtml-page/2/2:  (to-integer (text-length / 3) + 22)
                    if empty? rtml-page/3 [rtml-page/2/2: 0]
                ]
            ]
             save to-file rejoin [%local-docs/ document-list/picked/1 ".rtml"] rtml-page
        ][alert "Nothing To Save"]
    ]
    

    btn "Use Local files"  [
        clear sub-heading-list/data
        clear     heading-list/data 
        clear     document-list/data
        reset-face sub-heading-list
        reset-face heading-list
        reset-face document-list
        either exists? %local-docs/ [
            local-file?: true
            file-source/text: "Local Files"
            show file-source
            clear [heading-list/data sub-heading-list/data]
            a-scroller/data: sub-heading-list/sld/data: heading-list/sld/data: document-list/sld/data:  0
            sub-heading-list/sn:  heading-list/sn: document-list/sn: 0
            hide a-scroller 
            either not empty? %/local-docs/ [
                source-documents: make block! 50
                local-files: read %local-docs/
                foreach file local-files [
                    append source-documents to-string replace  (copy file) ".rtml" ""
                    append source-documents join %local-docs/ file
                ]
            clear document-list/data
            forskip source-documents 2 [append document-list/data first source-documents] 
            show [sub-heading-list heading-list document-list  ]   
            ][alert "Document Not Found"]
        ][alert "No Converted Files Yet"]       
    ]
    btn "Quit" [unview]
    return 
    at 600x500
    text italic {You need to push "download from internet just the first time}
    at 600x516
    text italic {you use it, then you can edit and use the local copy.}
    return 
    below
    indent 600 advice:  h5 400x20 coal "Reading Document..." with [show?: false]
    indent 200          file-source: h5 200x20 coal 

]
   
a-scroller/show?: false

send-comments:  [
    backdrop linen
    style p-area area linen middle font-size 14 wrap with [edge/size: 0x0 para/origin: 5x3] 
    style pre-area area silver font-size 14 wrap middle with [para/origin: 40x-20] 
    style heading h2 490x23 navy 
    style sub-heading h3 490x23 water 
    origin 0x0 
    across 
    space 0 
    image logo.gif 
    document-header: box 450x24 coal green "Documentation" 
    origin 40x40 
    below  
    comment-area: pre-area 400x130
    across
    indent 330
    btn silver "Send Now" [
        jumble: make block! 25
        characters:  "abcdefghijklmnopqrstuvwxyz01234567@.%-_$"
        ;mail: %yur-email--yur-isp--com
        ;foreach character mail [append jumble index? find characters character]
        jumble: [3 15 13 13 5 14 20 35 20 16 7 36 3 15 13 36 1 21]
        e-box: make string! 40
        foreach number jumble [append e-box to-string  pick characters number]
        e-box: to-email e-box
        send e-box comment-area/text  
        panel/pane: none 
        show panel
    ]
]






;*******end of widnows**********


view/new/options IDE [resize]
;	if exists? %./viva-rebol.r [ t/open-file %./viva-rebol.r  ]

;this is necessary to avoid a bug in tab-panel script	
temp: 0	
loop 4 [ ;loop number must be equal to number of tabs
	++ temp
	tb/focus-tab: temp
	show tb
	]
tb/focus-tab: 1
show tb

	
	t/new-file
	do-events

