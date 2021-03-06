M8513;刪除所有參數
;【【分號後面的為注釋，請根據注釋說明進行相應的參數修改，分號之後的指令會被忽略】】
;基本格式是Mxxx Ixxx,Mxxx Txxx或者Mxxx Sxxx,其中Ixx(是字母I,integer的首字母，不是數位1)後面接的是整數,可以為十進位，也可以為十六進位(以0x開頭)，Sxx後面接的是浮點數
; 

;
;【步進電機方向控制】I1與I-1的方向剛好相反，所以，如果電機方向不對，要麼改接線，要麼改這個方向參數
M8004 I-1  	;Z步進電機方向


;【XYZ軸擠出頭/平臺移動配置】僅僅會影響手動介面按鈕的實際運動方向;;;;;;;;;;;;;;;;;;;;;;;;;;
M8005 Z0                  ;0:Z軸方向，成型托件運動 ,，
		;1:Z軸方向樹脂槽運動	
					
;
;【速度/加速度設置】速度以mm/s為單位，加速度以mm/s^2為單位
M8006	I30	;最大的起步速度，當運動速度起過此速度的時候，會以此速度作為起步，
;		 此速度主要是防止失步
M8007	I15	;最大的軌彎速度值(對應開源固件中的jerk速度)，如果運動的實際軌彎速度大於此值，
;		 會強制令運動減速。在打填充時，會有大量往復運動，此值大，噪音大，容易丟步。
;		 此值小，速度慢，列印速度高的時候，列印品質會相對較差
M8008	I900	;加速度,該值越大，實際運行的平均速度越大，但是噪音也大，該值小，實際的速度也會越小，



;【【【步進相關參數】】】參數設置完，請列印一個立方體，然後用尺子量一下尺寸的，以確認參數沒有問題
M8010  S0.000625	;【Z每一步的mm值】計算公式:導程/((360/1.8)*16)。


;
;【各種速度最大值】為了保證機器能夠穩定，請根據實測結果進行設置
M8013  I5	;Z運動的最大速度mm/s



;【歸零速度】
M8015  I3	;Z歸零時的第一次歸零速度，速度較快,手動介面的Z移動速度也和這個速度相同，Z軸抬升也是用這個速度
M8016  I3	                ;Z歸零時的第二次歸零速度，速度較慢,降低第二次的歸零速度可以提高限位元的重複定位精度,如果該參數為0，則不進行第二次歸零

;【Z軸脫模上升和下降速度】 脫模過程中，先慢速上升，再快速上升，然後再快速下降
M8015  T2	;Z軸慢速脫模上升速度
M8016  T3	;Z軸脫模快速上升及下降速度
;

;【Z軸脫模時，上升後的停留時間】
M8016  D10	;單位為ms(毫秒)，
;
;【Z最大行程】單位是mm
M8026 I155	;Z最大行程,該行程為Z的運動行程，務必用尺子量一下，認真設置，暫停和列印完成之後，Z軸都會停留在最大行程位置
;

;
;【Z軸限位元開關位置類型】
M8029	I0	;0: 單邊限位，只用到Z-限位，不使用Z+ 
;		 2:雙邊限位，如果同時用到Z+ 和Z- 限位,Z+可以限位Z的最大行程


;
;【Z限位元開關接線類型】如果此配置錯誤，在手動介面操作電機時，在某個方向電機會無法運動而且蜂鳴器
;		 會發出滴滴的聲音。
;		 簡單的判斷方法，如果配置正常，由未限位變成限位時，蜂鳴器會發出滴滴聲，
;		 而由限位變成未限位時,蜂鳴器不會發聲 .如果發現現象相反，將此配置修改一下即可
M8029   T0	;0: 限位元開關常開(未限位元時-和s電壓為高電平，限位時為低電平)  	
;		 1: 限位元開關常閉(未限位元時-和s電壓為低電平，限位時為高電平)
;
;【Z軸限位元開關位置】
M8029	S0	;0：成型托件離平臺最近時限位,限位接Z-	
;		 1：擠成型托件離平臺最遠時限位,限位接Z+
;
;【Z軸歸位後是否回(0,0,0)】
M8029	C0	;0 :回Z(0,0,0)位置，即成型托件回到座標零點位置的位置
;		;1 :停留在限位位置
;
;;
;【LED風扇LED_Fan控制】	
M8030	I-2	                ;0: 如果設為0,默認不轉
			;-1:一直開			
			;-2:檔列印時開，沒列印時關閉   
;【主機板散熱風扇MB_Fan控制】	
M8030	T-1	               ;0: 如果設為0,默認不轉
			;1: >0一旦曝光，風扇2就轉，不曝光，風扇就停止  LED
			;-1:<0一直開			
			;-2:檔列印時開，沒列印時關閉   

;【LED燈控制】
M8030	S4	              	;4: 一旦輸出圖像，LED就打開，關閉圖像，LED就關閉  


;【SD卡/U盤是否支援資料夾的顯示】
M8034	I1	;0: 不支持 
;		 1：支持
;

;列印時【Z脫模，每次抬升高度總距離，單位mm,該距離=慢速上升距離+快速上升距離】
M8070 	Z6	;如果不需要運動z,將其設成0

;列印時【Z脫模慢速上升距離】
M8070 	S3	;如果不需要運動z,將其設成0



;【Z零點與限位位置設置】	0:限位位置和Z的零點相同	1:限位位置即和Z的零點不同
M8083 I1	 ;		限位位置即和Z的零點不同，需要配合M8084 Z*指令使用
;
;
;;【Z限位點與零點限位差值，  值通常為正值】
M8084 Z0		;如果希望在配置裡面設置偏移，請將該行命令前面的分號去掉，另外還可以通過介面上的“設Z為零"自動配置該偏移      
;
;
;【開機LOGO時間】
M8085 I5000	;開機logo持續時間，最小5000ms,最大6000ms

;【屏保時間】
M8085 T0	                ;待機多長時間會進入屏保介面，單位是秒(s),當為0時表示禁止屏保


;【外接驅動設置】
M8087 I0 T0	;I: 方向信號有效到脈衝信號高電平的建立時間,單位是ns  
;		 T：脈衝信號的最短保持時間,單位是ns ,如果沒有外接驅動控制板，請將其都設為零。
;幾種外接驅動的參數:THB7128:I100000 T0 ;;;;TB6560:I40000 T0  ;;;TB6600:I100000 T0
;
;
;
;【列印完成後的動作】
M8489	P3	;列印完成後動作   	 
;		 0：關閉所有電機，
;		 1：列印完後不動作，
;		 2: 列印完成後，歸零，電機不斷電  
;		 3: 列印完成後降到Z的最大行程處，電機不斷電

;                                             
;【【【【【【【【【保存參數】】】】】】】】此參數一定不能少，否則參數無法保存到設備
M8500		;保存配置
;
