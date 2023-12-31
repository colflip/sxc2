    MODULE SHARE_PRECISION
    IMPLICIT NONE
    INTEGER, PARAMETER :: SGL = SELECTED_REAL_KIND(6)
    INTEGER, PARAMETER :: DBL = SELECTED_REAL_KIND(14)
    INTEGER, PARAMETER :: DBL2 = SELECTED_REAL_KIND(28)
    END MODULE SHARE_PRECISION
    
    MODULE SHARE_VAR
    USE SHARE_PRECISION
    IMPLICIT NONE
    INTEGER, PARAMETER :: NUM_CHAR = 5
    INTEGER, PARAMETER :: NUM_KEY = 60
    INTEGER :: IP, IA, IB
    INTEGER, DIMENSION(2) :: Inf_POINT(2)
    INTEGER :: G_RANK
    INTEGER, DIMENSION(2) :: G_POINT(2)

    INTEGER, DIMENSION(NUM_KEY) :: r_Vector, Secret_Message, Hash_Vector, SN_Vector
    INTEGER, DIMENSION(NUM_KEY, 2) :: PUBLIC_Key_POINT_ARRAY

    REAL(KIND = DBL), DIMENSION(50) :: TEMP_VAR_INT, TEMP_VAR_REAL
    INTEGER :: RAN, DAY_REGISTER, HOUR_REGISTER, NUM_REGISTER
    INTEGER, DIMENSION(7) :: TIME_REGISTER, TIME_USE
    INTEGER :: COUNT_VAR
    
    CONTAINS

    FUNCTION GET_MSG(PATH, LEN_PATH)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: LEN_PATH
    CHARACTER(LEN = LEN_PATH), INTENT(IN) :: PATH
    INTEGER :: I, IOST
    INTEGER, PARAMETER :: NUM_ALL = 1840
    CHARACTER(LEN = 256) :: FILE_MSG
    CHARACTER(LEN = NUM_CHAR), DIMENSION(NUM_KEY) :: CHAR_P_1, CHAR_P_2, CHAR_RR, CHAR_SMSG, CHAR_Hash, CHAR_SN
    CHARACTER(LEN = NUM_CHAR) :: CHAR_IP, CHAR_IA, CHAR_IB, CHAR_G_1, CHAR_G_2, CHAR_G_RANK, CHAR_Inf_1, CHAR_Inf_2
    REAL(KIND = DBL), DIMENSION(NUM_ALL) :: TEMP
    REAL(KIND = DBL), DIMENSION(192) :: TEMP_VAR_TIME
    INTEGER, DIMENSION(96) :: VAR_TIME
    CHARACTER(LEN = 96) :: CHAR_TIME_NUM
    CHARACTER(LEN = NUM_CHAR) :: CHAR_RAN, CHAR_DAY_REGISTER, CHAR_HOUR_REGISTER, CHAR_NUM_REGISTER
    CHARACTER(LEN = NUM_CHAR), DIMENSION(7) :: CHAR_TIME_REGISTER, CHAR_TIME_USE
    INTEGER :: USED_TIME
    INTEGER :: GET_MSG
    LOGICAL :: VAR_LOGIC
    
    INQUIRE(FILE = PATH(1:LEN_PATH)//'main.opt', EXIST = VAR_LOGIC)
    IF(VAR_LOGIC == .FALSE.)THEN
        GET_MSG = 1
        RETURN
    ENDIF
    OPEN(34, FILE = PATH(1:LEN_PATH)//'main.opt', ACCESS = 'DIRECT', FORM = 'UNFORMATTED', RECL = 4, STATUS = 'OLD',&
        &       ACTION = 'READ', IOSTAT = IOST, IOMSG = FILE_MSG)
        IF(IOST .NE. 0)THEN
            GET_MSG = 2
            CLOSE(34)
            RETURN
        ENDIF
        
        DO I = 1, NUM_ALL
            READ(34, REC = I, IOMSG = FILE_MSG, IOSTAT = IOST)TEMP(I)
            IF(IOST .NE. 0) EXIT
        ENDDO
        IF(IOST .NE. 0)THEN
            GET_MSG = 3
            CLOSE(34)
            RETURN
        ENDIF

        CHAR_IP = ACHAR(FLOOR(TEMP(1)))//ACHAR(FLOOR(TEMP(2)))//ACHAR(FLOOR(TEMP(3)))//ACHAR(FLOOR(TEMP(4)))//ACHAR(FLOOR(TEMP(5)))
        CHAR_IA = ACHAR(FLOOR(TEMP(NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(NUM_CHAR+5)))
        CHAR_G_1 = ACHAR(FLOOR(TEMP(3*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(3*NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(3*NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(3*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(3*NUM_CHAR+5)))
        CHAR_G_2 = ACHAR(FLOOR(TEMP(4*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(4*NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(4*NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(4*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(4*NUM_CHAR+5)))
        CHAR_G_RANK = ACHAR(FLOOR(TEMP(5*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(5*NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(5*NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(5*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(5*NUM_CHAR+5)))
        CHAR_Inf_1 = ACHAR(FLOOR(TEMP(6*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(6*NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(6*NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(6*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(6*NUM_CHAR+5)))
        CHAR_Inf_2 = ACHAR(FLOOR(TEMP(7*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(7*NUM_CHAR+2)))//ACHAR(FLOOR(TEMP(7*NUM_CHAR+3)))// &
            &   ACHAR(FLOOR(TEMP(7*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(7*NUM_CHAR+5)))
        DO I = 1, NUM_KEY
            CHAR_P_1(I) = ACHAR(FLOOR(TEMP(8*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(8*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(8*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(8*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(8*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
            CHAR_P_2(I) = ACHAR(FLOOR(TEMP(9*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(9*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(9*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(9*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(9*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
            CHAR_RR(I) = ACHAR(FLOOR(TEMP(10*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(10*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(10*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(10*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(10*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
            CHAR_SMSG(I) = ACHAR(FLOOR(TEMP(11*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(11*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(11*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(11*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(11*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
            CHAR_Hash(I) = ACHAR(FLOOR(TEMP(12*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(12*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(12*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(12*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(12*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
            CHAR_SN(I) = ACHAR(FLOOR(TEMP(13*NUM_CHAR+6*(I-1)*NUM_CHAR+1)))//ACHAR(FLOOR(TEMP(13*NUM_CHAR+6*(I-1)*NUM_CHAR+2)))// &
                &   ACHAR(FLOOR(TEMP(13*NUM_CHAR+6*(I-1)*NUM_CHAR+3)))// &
                &   ACHAR(FLOOR(TEMP(13*NUM_CHAR+6*(I-1)*NUM_CHAR+4)))//ACHAR(FLOOR(TEMP(13*NUM_CHAR+6*(I-1)*NUM_CHAR+5)))
        ENDDO
        COUNT_VAR = NUM_ALL+30
        DO I = COUNT_VAR+1, COUNT_VAR+192
            READ(34, REC = I, IOMSG = FILE_MSG, IOSTAT = IOST)TEMP_VAR_TIME(I-COUNT_VAR)
            IF(IOST .NE. 0) EXIT
        ENDDO
        IF(IOST .NE. 0)THEN
            GET_MSG = 3
            CLOSE(34)
            RETURN
        ENDIF
        
        DO I = 1, 96
            VAR_TIME(I) = IEOR(FLOOR(TEMP_VAR_TIME(2*I-1)),FLOOR(TEMP_VAR_TIME(2*I)))
            CHAR_TIME_NUM(I:I) = ACHAR(VAR_TIME(I))
        ENDDO
        IF(CHAR_TIME_NUM(1:1) == 'H' .AND. CHAR_TIME_NUM(38:38) == 'Z' .AND. CHAR_TIME_NUM(45:45) == 'X' &
            &   .AND. CHAR_TIME_NUM(52:52) == 'M' .AND. CHAR_TIME_NUM(59:59) == 'K' .AND. CHAR_TIME_NUM(96:96) == 'J')THEN
            CHAR_RAN(2:2) = CHAR_TIME_NUM(39:39)
            CHAR_RAN(3:3) = CHAR_TIME_NUM(46:46)
            CHAR_RAN(4:4) = CHAR_TIME_NUM(53:53)
            CHAR_RAN(5:5) = CHAR_TIME_NUM(60:60)
            CHAR_RAN(1:1) = CHAR_TIME_NUM(2:2)
            CALL CHAR2INT(CHAR_RAN, RAN)
            
            DO I = 1, 7
                CHAR_TIME_REGISTER(I) = CHAR_TIME_NUM(2+1+(I-1)*NUM_CHAR:2+NUM_CHAR+(I-1)*NUM_CHAR)
                CALL CHAR2INT(CHAR_TIME_REGISTER(I), TIME_REGISTER(I))
                TIME_REGISTER(I) = IEOR(TIME_REGISTER(I), RAN)
            ENDDO
            
            CHAR_DAY_REGISTER = CHAR_TIME_NUM(40:44)
            CALL CHAR2INT(CHAR_DAY_REGISTER, DAY_REGISTER)
            DAY_REGISTER = IEOR(DAY_REGISTER, RAN+8)
            
            CHAR_HOUR_REGISTER = CHAR_TIME_NUM(47:51)
            CALL CHAR2INT(CHAR_HOUR_REGISTER, HOUR_REGISTER)
            HOUR_REGISTER = IEOR(HOUR_REGISTER, RAN+16)
            
            CHAR_NUM_REGISTER = CHAR_TIME_NUM(54:58)
            CALL CHAR2INT(CHAR_NUM_REGISTER, NUM_REGISTER)
            NUM_REGISTER = IEOR(NUM_REGISTER, RAN+24)
            
            DO I = 1, 7
                CHAR_TIME_USE(I) = CHAR_TIME_NUM(60+1+(I-1)*NUM_CHAR:60+I*NUM_CHAR)
                CALL CHAR2INT(CHAR_TIME_USE(I), TIME_USE(I))
                TIME_USE(I) = IEOR(TIME_USE(I), RAN)
            ENDDO
        ELSE
            GET_MSG = 4
            CLOSE(34)
            RETURN
        ENDIF
        
        USED_TIME = ((TIME_USE(1)-TIME_REGISTER(1))*365 + (TIME_USE(2)-TIME_REGISTER(2))*30 + (TIME_USE(3)-TIME_REGISTER(3)))*24*60 &
        &   + (TIME_USE(4)-TIME_REGISTER(4))*60 + (TIME_USE(5)-TIME_REGISTER(5))
        
        IF(USED_TIME < 0)THEN
!        IF(USED_TIME < 0 .OR. NUM_REGISTER <= 0)THEN
            GET_MSG = 5
            CLOSE(34)
            RETURN
        ENDIF
        IF(DAY_REGISTER < 0)THEN
            GET_MSG = 5
            CLOSE(34)
            RETURN
        ELSEIF(DAY_REGISTER == 0)THEN
            IF(HOUR_REGISTER < 0)THEN
                GET_MSG = 5
                CLOSE(34)
                RETURN
            ENDIF
        ENDIF
        
        DO I = NUM_ALL+1, NUM_ALL+30
            READ(34, REC = I, IOMSG = FILE_MSG, IOSTAT = IOST)TEMP_VAR_INT(I-NUM_ALL)
            IF(IOST .NE. 0) EXIT
        ENDDO
        IF(IOST .NE. 0)THEN
            GET_MSG = 3
            CLOSE(34)
            RETURN
        ENDIF
        
    CLOSE(34)
    
    CALL CHAR2INT(CHAR_IP, IP)
    CALL CHAR2INT(CHAR_IA, IA)
    CALL CHAR2INT(CHAR_G_1, G_POINT(1))
    CALL CHAR2INT(CHAR_G_2, G_POINT(2))
    CALL CHAR2INT(CHAR_G_RANK, G_RANK)
    CALL CHAR2INT(CHAR_Inf_1, Inf_POINT(1))
    CALL CHAR2INT(CHAR_Inf_2, Inf_POINT(2))
    DO I = 1, NUM_KEY
        CALL CHAR2INT(CHAR_P_1(I), PUBLIC_Key_POINT_ARRAY(I,1))
        CALL CHAR2INT(CHAR_P_2(I), PUBLIC_Key_POINT_ARRAY(I,2))
        CALL CHAR2INT(CHAR_RR(I), r_VECTOR(I))
        CALL CHAR2INT(CHAR_SMSG(I), Secret_Message(I))
        CALL CHAR2INT(CHAR_Hash(I), Hash_Vector(I))
        CALL CHAR2INT(CHAR_SN(I), SN_Vector(I))
    ENDDO
    
    GET_MSG = 0

    END FUNCTION GET_MSG

    END MODULE SHARE_VAR
    
    
    
    MODULE VAR_INV1D
    USE SHARE_PRECISION
    USE SHARE_VAR, ONLY : TEMP_VAR_INT
    IMPLICIT NONE
    INTEGER :: P, N, M, NUMRI, COLUMN, FLAG_INV1D
    CONTAINS

    FUNCTION GET_VAR1()
    IMPLICIT NONE
    INTEGER :: I, N_TEMP
    REAL(KIND = DBL), DIMENSION(12) :: TEMP
    INTEGER :: GET_VAR1
    
    DO I = 1, 12
        TEMP(I) = TEMP_VAR_INT(I)
    ENDDO
    FLAG_INV1D = IEOR(FLOOR(TEMP(1)),FLOOR(TEMP(2)))
    IF(FLAG_INV1D .NE. 1)THEN
        GET_VAR1 = 1
        RETURN
    ENDIF
    P = IEOR(FLOOR(TEMP(3)),FLOOR(TEMP(4)))
    N = IEOR(FLOOR(TEMP(5)),FLOOR(TEMP(6)))
    M = IEOR(FLOOR(TEMP(7)),FLOOR(TEMP(8)))
    NUMRI = IEOR(FLOOR(TEMP(9)),FLOOR(TEMP(10)))
    COLUMN = IEOR(FLOOR(TEMP(11)),FLOOR(TEMP(12)))
    
    GET_VAR1 = 0
    END FUNCTION GET_VAR1

    END MODULE VAR_INV1D

    MODULE VAR_ECC_BHC
    USE SHARE_PRECISION
    USE SHARE_VAR, ONLY : TEMP_VAR_INT
    IMPLICIT NONE
    INTEGER :: P2, N2, P1, N1, M, INDEXDH, INDEXECC, COLUMN, FLAG_ECC_BHC
    
    CONTAINS

    FUNCTION GET_VAR2()
    IMPLICIT NONE
    INTEGER :: I, N_TEMP
    REAL(KIND = DBL), DIMENSION(18) :: TEMP
    INTEGER :: GET_VAR2

    DO I = 1, 18
        TEMP(I) = TEMP_VAR_INT(I+12)
    ENDDO
    FLAG_ECC_BHC = IEOR(FLOOR(TEMP(1)),FLOOR(TEMP(2)))
    IF(FLAG_ECC_BHC .NE. 1)THEN
        GET_VAR2 = 1
        RETURN
    ENDIF
    P2 = IEOR(FLOOR(TEMP(3)),FLOOR(TEMP(4)))
    N2 = IEOR(FLOOR(TEMP(5)),FLOOR(TEMP(6)))
    P1 = IEOR(FLOOR(TEMP(7)),FLOOR(TEMP(8)))
    N1 = IEOR(FLOOR(TEMP(9)),FLOOR(TEMP(10)))
    M = IEOR(FLOOR(TEMP(11)),FLOOR(TEMP(12)))
    INDEXDH = IEOR(FLOOR(TEMP(13)),FLOOR(TEMP(14)))
    INDEXECC = IEOR(FLOOR(TEMP(15)),FLOOR(TEMP(16)))
    COLUMN = IEOR(FLOOR(TEMP(17)),FLOOR(TEMP(18)))
    
    GET_VAR2 = 0
    END FUNCTION GET_VAR2

    END MODULE VAR_ECC_BHC

    MODULE CPROG
        INTERFACE
            SUBROUTINE SHA_1(MACHINE_CODE, LENGTH, OUTPUT)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_sha1' :: SHA_1
            CHARACTER(LEN = *) :: MACHINE_CODE
            INTEGER :: LENGTH
            CHARACTER(LEN = 20) :: OUTPUT
!            !DEC$ ATTRIBUTES REFERENCE :: MACHINE_CODE, OUTPUT
!            !DEC$ ATTRIBUTES VALUE :: LENGTH
            END SUBROUTINE
            SUBROUTINE SHA_2(MACHINE_CODE, LENGTH, OUTPUT, IS)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_sha2' :: SHA_2
            CHARACTER(LEN = *) :: MACHINE_CODE
            INTEGER :: LENGTH, IS
            CHARACTER(LEN = 32) :: OUTPUT
!            !DEC$ ATTRIBUTES REFERENCE :: MACHINE_CODE, OUTPUT
!            !DEC$ ATTRIBUTES VALUE :: LENGTH, IS
            END SUBROUTINE
            SUBROUTINE SHA_4(MACHINE_CODE, LENGTH, OUTPUT, IS)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_sha4' :: SHA_4
            CHARACTER(LEN = *) :: MACHINE_CODE
            INTEGER :: LENGTH, IS
            CHARACTER(LEN = 64) :: OUTPUT
!            !DEC$ ATTRIBUTES REFERENCE :: MACHINE_CODE, OUTPUT
!            !DEC$ ATTRIBUTES VALUE :: LENGTH, IS
            END SUBROUTINE
            
            SUBROUTINE Get_Disk_MSG(Disk_CODE)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_getHardDriveID' :: Get_Disk_MSG
            CHARACTER(LEN = 1024) :: Disk_CODE
!            !DEC$ ATTRIBUTES REFERENCE :: Disk_CODE
            END SUBROUTINE

            SUBROUTINE Get_CPU_MSG(CPU_CODE)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_GetCpuSerialNumber' :: Get_CPU_MSG
            CHARACTER(LEN = *) :: CPU_CODE
!            !DEC$ ATTRIBUTES REFERENCE :: CPU_CODE
            END SUBROUTINE

            FUNCTION Get_MAC_MSG(MAC_CODE)
!            !DEC$ ATTRIBUTES DLLIMPORT, ALIAS: '_getMacInfo' :: Get_MAC_MSG
            LOGICAL Get_MAC_MSG
            CHARACTER(LEN = *) :: MAC_CODE
!            !DEC$ ATTRIBUTES REFERENCE :: MAC_CODE
            END FUNCTION
        END INTERFACE
    
    END MODULE CPROG
    
    SUBROUTINE SHAA(MACHINE_CODE, LENGTH, N_KIND, OUTPUT)
    USE CPROG
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: LENGTH, N_KIND
    CHARACTER(LEN = LENGTH), INTENT(IN) :: MACHINE_CODE
    CHARACTER(LEN = *), INTENT(inOUT) :: OUTPUT
    
    
    IF(N_KIND == 1)THEN
!        CALL SHA_1(MACHINE_CODE, LENGTH, OUTPUT)
    ELSEIF(N_KIND == 2)THEN
!        CALL SHA_2(MACHINE_CODE, LENGTH, OUTPUT, 0)
    ELSEIF(N_KIND == 3)THEN
!        CALL SHA_2(MACHINE_CODE, LENGTH, OUTPUT, 1)
    ELSE
!        CALL SHA_2(MACHINE_CODE, LENGTH, OUTPUT, 0)
    ENDIF
    
    END SUBROUTINE SHAA



SUBROUTINE EFFCHECK(FILENAME03, STR_LEN, EFF_CHECK)
!    USE DATA_HRLA_1DINV
IMPLICIT NONE
! VARIANCE FOR PATH
INTEGER, INTENT(IN) :: STR_LEN
CHARACTER(LEN = STR_LEN), INTENT(IN) :: FILENAME03
INTEGER :: FILELEN03
!!DEC$ ATTRIBUTES REFERENCE :: FILENAME03
!!DEC$ ATTRIBUTES VALUE :: STR_LEN
INTEGER,INTENT(OUT):: EFF_CHECK
! VARIANCE FOR DECRYPTION
INTEGER :: RET_JUDGE, I_FLAG,I_MSG_S_L
INTEGER, EXTERNAL :: TIME_NUM_JUDGE
! VARIANCE FOR LIBFILE
!    INTEGER :: ID, I, COUNT, IRI, J, K
!    INTEGER VALUES(8),VALUE0(3)
!    REAL*8,ALLOCATABLE::AA(:),BB(:)
!    REAL*8 :: TEMP
!    INTEGER :: IOST   
FILELEN03=LEN_TRIM(FILENAME03)
CALL Decryption(FILENAME03, FILELEN03, I_MSG_S_L)   
!    PRINT*,I_MSG_S_L,'I_MSG_S_L'
I_FLAG = 2
RET_JUDGE = TIME_NUM_JUDGE(FILENAME03, FILELEN03, I_MSG_S_L, I_FLAG)
!    PRINT*,RET_JUDGE, 'RET_JUDGE'
!    pause
EFF_CHECK = 0
IF(RET_JUDGE + I_MSG_S_L .NE. 0)THEN
EFF_CHECK = RET_JUDGE + I_MSG_S_L
RETURN
ENDIF
!    PRINT*,'Congratulations, Pass Check !'
RETURN
END SUBROUTINE EFFCHECK

    SUBROUTINE Decryption(PATH, LEN_PATH, I_MSG_S_L)
    !DEC$ ATTRIBUTES DLLIMPORT :: sha
    !DEC$ ATTRIBUTES DLLIMPORT :: GetInfo
    USE SHARE_PRECISION
    USE SHARE_VAR
    USE CPROG
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: LEN_PATH
    CHARACTER(LEN = LEN_PATH), INTENT(IN) :: PATH
    INTEGER, INTENT(OUT) :: I_MSG_S_L

    CHARACTER(LEN = 100) :: MACHINE_SERIAL
    CHARACTER(LEN = 100) :: MACHINE_SERIAL2
    INTEGER :: LEN_HD, LEN_MAC_SER
    CHARACTER(LEN = 1024) :: HD_SERIAL_F
    CHARACTER(LEN = 1024) :: HD_SERIAL_FT

    INTEGER :: I, II, J, PRIVATE_KEY, NUM
    INTEGER, DIMENSION(2) :: POINT, POINT2, POINT3, POINT4
    INTEGER, DIMENSION(2) :: PUBLIC_Key_POINT ! 公钥
    REAL(KIND = DBL) :: SEED
    INTEGER, EXTERNAL :: Negative, INV
    INTEGER :: Hash
    INTEGER, DIMENSION(2) :: RAN_POINT
    INTEGER :: LENGTH, N_KIND
    CHARACTER(LEN = 32) :: OUTPUT
    CHARACTER(LEN = 200) :: MACHINE_CODE, MACHINE_CODE2
    INTEGER :: W, U, V, RR
    INTEGER, DIMENSION(2) :: P_POINT, Q_POINT, R_POINT
    INTEGER, DIMENSION(2) :: TEM1_POINT, TEM2_POINT, TEM_R_POINT
    CHARACTER(LEN = NUM_CHAR) :: CHAR_R_1, CHAR_R_2
    CHARACTER(LEN = 2*NUM_CHAR) :: CHAR_R

    CHARACTER(LEN = 50) :: CPU_SN, CPU_SN_F, MAC_INFO, MAC_INFO_F
    CHARACTER(LEN = 100) :: MACHINE_INFO
    CHARACTER(LEN = 30) :: DISCODE_T, DISCODE
    INTEGER :: LEN_CPU, LEN_MAC, LEN_INFO, LEN_DC
    

    CHARACTER(LEN = 100) :: HD_SERIAL_F_I
    CHARACTER(LEN = 20) :: HD_SERIAL_HA, MACHINE_HASH
    INTEGER, DIMENSION(50) :: I_HD_SERIAL_HA, I_MACHINE_HASH
    CHARACTER(LEN = 2), DIMENSION(50) :: CHA_HD
    INTEGER :: I_COUNT
    CHARACTER(LEN = 2) :: CHAR_TEMP
    REAL(KIND = DBL) :: TTT
    LOGICAL FLAG
    INTEGER :: RET_GET_MSG
    
    I_MSG_S_L = 0
    TTT = 1.25_DBL
        
!    CALL Get_CPU_MSG(CPU_SN)
    CALL STR_TRIM(CPU_SN, 50, CPU_SN_F, LEN_CPU)
    
!    FLAG = Get_MAC_MSG(MAC_INFO)
    IF(FLAG)THEN
        CALL STR_TRIM(MAC_INFO, 50, MAC_INFO_F, LEN_MAC)
    ELSE
!        MAC_INFO_F = "BFEBFBFF000206A7"
!        LEN_MAC = 16
    ENDIF
!    
!    OPEN(23,FILE = 'E:\MACHINE.TXT', STATUS = 'UNKNOWN')
!        WRITE(23,*)CPU_SN_F, LEN_CPU
!        WRITE(23,*)MAC_INFO_F, LEN_MAC
!    CLOSE(23)

!    CALL Get_Disk_MSG(HD_SERIAL_FT)
    CALL STR_TRIM(HD_SERIAL_FT, 1024, HD_SERIAL_F, LEN_HD)
    
    MACHINE_INFO = CPU_SN_F(1:LEN_CPU)//HD_SERIAL_F(1:LEN_HD)//MAC_INFO_F(1:LEN_MAC)
    LEN_INFO = LEN_CPU+LEN_HD+LEN_MAC
!    CALL SHAA(MACHINE_INFO, LEN_INFO, 1, MACHINE_HASH)
    I_COUNT = 0
    DO I = 1, LEN_TRIM(MACHINE_HASH)
        I_MACHINE_HASH(I) = IACHAR(MACHINE_HASH(I:I))
        CALL INT2HEXCHAR(I_MACHINE_HASH(I), CHA_HD(I))
        DO J = 1, LEN_TRIM(CHA_HD(I))
            CHAR_TEMP = CHA_HD(I)
            I_COUNT = I_COUNT + 1
            MACHINE_SERIAL(I_COUNT:I_COUNT) = CHAR_TEMP(J:J)
        ENDDO
    ENDDO
!    PRINT*,MACHINE_SERIAL(1:I_COUNT),'MACHINE_SERIAL'
    LEN_MAC_SER = I_COUNT
    IF(LEN_MAC_SER .NE. 40)THEN
        I_MSG_S_L = 3
        RETURN
    ENDIF

    RET_GET_MSG = GET_MSG(PATH, LEN_PATH)
!    PRINT*,RET_GET_MSG,'RET_GET_MSG'
    IF(RET_GET_MSG .NE. 0)THEN
        I_MSG_S_L = 1
        RETURN
    ENDIF
!    CALL SHAA(HD_SERIAL_F, LEN_HD, 1, HD_SERIAL_HA)
    I_COUNT = 0
    DO I = LEN_TRIM(HD_SERIAL_HA)-5, LEN_TRIM(HD_SERIAL_HA)
        I_HD_SERIAL_HA(I) = IACHAR(HD_SERIAL_HA(I:I))
        CALL INT2HEXCHAR(I_HD_SERIAL_HA(I), CHA_HD(I))
        DO J = 1, LEN_TRIM(CHA_HD(I))
            CHAR_TEMP = CHA_HD(I)
            I_COUNT = I_COUNT + 1
            HD_SERIAL_F_I(I_COUNT:I_COUNT) = CHAR_TEMP(J:J)
        ENDDO
    ENDDO

    OPEN(12, FILE = PATH(1:LEN_PATH)//'discode.txt', STATUS = 'OLD')
        READ(12,*)DISCODE_T
    CLOSE(12)
    CALL STR_TRIM(DISCODE_T, 30, DISCODE, LEN_DC)
    IF(LEN_DC .NE. 6)THEN
        I_MSG_S_L = 3
        RETURN
    ENDIF

    MACHINE_SERIAL2 = MACHINE_SERIAL(1:LEN_MAC_SER)//HD_SERIAL_F_I(1:I_COUNT)//DISCODE(1:LEN_DC)
    LEN_MAC_SER = 58
!    PRINT*,MACHINE_SERIAL2,'MACHINE_SERIAL2', RET_GET_MSG
    
    N_KIND = 2
    DO I = 1, NUM_KEY
        MACHINE_CODE(1:LEN_MAC_SER) = MACHINE_SERIAL2(1:LEN_MAC_SER)
        IF(MODULO(r_VECTOR(I), G_RANK) ==0 .OR. MODULO(Secret_Message(I), G_RANK) ==0)THEN
            I_MSG_S_L = 2
            RETURN
        ENDIF

        CALL MULT(SN_Vector(I), G_POINT, TEM1_POINT)
        CALL MULT(Hash_Vector(I), PUBLIC_Key_POINT_ARRAY(I,:), TEM2_POINT)
        CALL ADD(TEM1_POINT, TEM2_POINT, TEM_R_POINT)

        CALL INT2CHAR(TEM_R_POINT(1), CHAR_R_1)
        CALL INT2CHAR(TEM_R_POINT(2), CHAR_R_2)
        CHAR_R(1:2*NUM_CHAR) = CHAR_R_1(1:NUM_CHAR)//CHAR_R_2(1:NUM_CHAR)
        MACHINE_CODE2 = MACHINE_CODE(1:LEN_MAC_SER)//CHAR_R(1:2*NUM_CHAR)
!        CALL SHAA(MACHINE_CODE2, LEN_MAC_SER+2*NUM_CHAR, N_KIND, OUTPUT)      ! 调用安全散列算法SHA2计算信息(如机器码)的Hash值
        Hash = MODULO(IACHAR(OUTPUT(1:1)) + IACHAR(OUTPUT(16:16)) + IACHAR(OUTPUT(23:23)) + IACHAR(OUTPUT(32:32)), G_RANK)
        IF(Hash_Vector(I) == Hash)THEN
        ELSE
            I_MSG_S_L = 2
            RETURN
        ENDIF

        W = INV(Secret_Message(I), G_RANK)
        U = MODULO(Hash*W, G_RANK)
        V = MODULO(r_VECTOR(I)*W, G_RANK)
    
        CALL MULT(U, G_POINT, P_POINT)
        CALL MULT(V, PUBLIC_Key_POINT_ARRAY(I,:), Q_POINT)
        CALL ADD(P_POINT, Q_POINT, R_POINT)
        IF(R_POINT(1) == Inf_POINT(1) .AND. R_POINT(2) == Inf_POINT(2))THEN
            I_MSG_S_L = 2
            RETURN
        ENDIF
        RR = MODULO(R_POINT(1), G_RANK)
        IF(RR == r_VECTOR(I))THEN
        ELSE
            I_MSG_S_L = 2
            RETURN
        ENDIF
    ENDDO

    END SUBROUTINE Decryption
    
    SUBROUTINE ADD(P, Q, R)
    USE SHARE_PRECISION
    USE SHARE_VAR
    IMPLICIT NONE
    INTEGER, INTENT(IN), DIMENSION(2) :: P, Q
    INTEGER :: IX_P, IY_P, IX_Q, IY_Q
    INTEGER :: k_T1, k_T2, k, k_T2_INV
    INTEGER, EXTERNAL :: INV, Negative
    INTEGER, INTENT(OUT), DIMENSION(2) :: R
    
    IX_P = P(1)
    IY_P = P(2)
    IX_Q = Q(1)
    IY_Q = Q(2)
    IF(IX_P == Inf_POINT(1) .AND. IY_P == Inf_POINT(2))THEN
        R(1) = IX_Q
        R(2) = IY_Q
        RETURN
    ELSEIF(IX_Q == Inf_POINT(1) .AND. IY_Q == Inf_POINT(2))THEN
        R(1) = IX_P
        R(2) = IY_P
        RETURN
    ENDIF
    IF(IY_Q == IY_P .AND. IX_Q == IX_P)THEN
        k_T1 = 3*IX_P*IX_P+IA
        k_T2 = 2*IY_P
        IF(IY_P == 0)THEN
            R(1) = Inf_POINT(1)
            R(2) = Inf_POINT(2)
            RETURN
        ENDIF
    ELSE
        k_T1 = IY_Q-IY_P
        k_T2 = IX_Q-IX_P
        IF(IX_Q == IX_P)THEN
            R(1) = Inf_POINT(1)
            R(2) = Inf_POINT(2)
            RETURN
        ENDIF
    ENDIF
    k_T1 = MODULO(k_T1, IP)
    k_T2 = MODULO(k_T2, IP)
    k_T2_INV = INV(k_T2, IP)
    k = MODULO(k_T1*k_T2_INV, IP)
    
    R(1) = MODULO(k*k - IX_P - IX_Q, IP)
    R(2) = MODULO(k*(IX_P-R(1)) - IY_P, IP)
    
    END SUBROUTINE ADD
    
    FUNCTION INV(IK, IP_T)
    USE SHARE_PRECISION
    USE SHARE_VAR
    IMPLICIT NONE 
    INTEGER, INTENT(IN) :: IK, IP_T
    INTEGER :: I, IK_INV
    INTEGER :: INV
    
    IF(IK == 0)THEN
!        WRITE(*,*)'IK CAN NOT BE 0 !'
        RETURN
    ELSE
        DO I = 1, IP_T-1
            IK_INV = I
            IF(MODULO(IK*IK_INV, IP_T) == 1)THEN
                INV = IK_INV
                RETURN
            ENDIF
        ENDDO
    ENDIF
    IF(IK_INV == IP_T-1)THEN
!        WRITE(*,*)'IK IS NOT HAVE INV !'
    ENDIF
    
    END FUNCTION INV
    
    FUNCTION Negative(IK)
    USE SHARE_PRECISION
    USE SHARE_VAR
    IMPLICIT NONE 
    INTEGER, INTENT(IN) :: IK
    INTEGER :: Negative
    
    Negative = MODULO(IK, IP)
    
    END FUNCTION Negative
    
!    SUBROUTINE MULT(KEY, POINT, POINT2)
!    USE SHARE_PRECISION
!    USE SHARE_VAR
!    IMPLICIT NONE 
!    INTEGER, INTENT(IN) :: KEY
!    INTEGER, INTENT(IN), DIMENSION(2) :: POINT
!    INTEGER, INTENT(OUT), DIMENSION(2) :: POINT2
!    INTEGER, DIMENSION(2) :: P1, P2, R
!    INTEGER, DIMENSION(100,2) :: P3
!    INTEGER :: I, KEY_T, N
!    
!    KEY_T = KEY
!
!    P1(1) = POINT(1)
!    P1(2) = POINT(2)
!
!    N = FLOOR(LOG(KEY_T*1.0_DBL)/LOG(2.0_DBL))
!    DO I = 1, N
!        CALL ADD(P1, P1, R)
!        P1(1) = R(1)
!        P1(2) = R(2)
!        P3(I,1) = R(1)
!        P3(I,2) = R(2)
!    ENDDO
!    KEY_T = KEY_T - 2**N
!    DO I = 1, N
!        PRINT*,KEY_T, N, 'KEY_T  N'
!        KEY_T = KEY_T - 2**(N-I)
!        P1(1) = R(1)
!        P1(2) = R(2)
!        P2(1) = P3(N-I,1)
!        P2(2) = P3(N-I,2)
!        IF(KEY_T >= 0)THEN
!            CALL ADD(P1,P2,R)
!        ELSE
!        ENDIF
!    ENDDO
!
!    POINT2(1) = R(1)
!    POINT2(2) = R(2)
!    
!    END SUBROUTINE MULT
    

    SUBROUTINE MULT(KEY, POINT, POINT2)
    USE SHARE_PRECISION
    USE SHARE_VAR
    IMPLICIT NONE 
    INTEGER, INTENT(IN) :: KEY
    INTEGER, INTENT(IN), DIMENSION(2) :: POINT
    INTEGER, INTENT(OUT), DIMENSION(2) :: POINT2
    INTEGER, DIMENSION(2) :: P1, P2, R
    INTEGER :: I
    
    P1(1) = POINT(1)
    P1(2) = POINT(2)
    P2(1) = POINT(1)
    P2(2) = POINT(2)
    DO I = 1, KEY-1
        CALL ADD(P2, P1, R)
        P2(1) = R(1)
        P2(2) = R(2)
    ENDDO
    POINT2(1) = P2(1)
    POINT2(2) = P2(2)
    
    END SUBROUTINE MULT
    
  SUBROUTINE INT2CHAR(INT, CHAR)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: INT
    CHARACTER(LEN = 5), INTENT(OUT) :: CHAR
    INTEGER :: INT2, TEM1, TEM2, TEM3, TEM4, TEM5

    INT2 = INT
    TEM1 = MOD(INT2, 10)
    INT2 = INT2/10
    TEM2 = MOD(INT2,10)
    INT2 = INT2/10
    TEM3 = MOD(INT2,10)
    INT2 = INT2/10
    TEM4 = MOD(INT2,10)
    INT2 = INT2/10
    TEM5 = MOD(INT2,10)
    CHAR = ACHAR(2*TEM1+32)//ACHAR(3*TEM2+49)//ACHAR(4*TEM3+58)//ACHAR(TEM4+65)//ACHAR(TEM5+117)

    END SUBROUTINE INT2CHAR

    SUBROUTINE CHAR2INT(CHARA, INT)
    USE SHARE_VAR, ONLY: NUM_CHAR
    IMPLICIT NONE
    CHARACTER(LEN = NUM_CHAR), INTENT(IN) :: CHARA
    INTEGER, INTENT(OUT) :: INT
    INTEGER :: INT2

    INT2 = IACHAR(CHARA(5:5))-117
    INT2 = INT2 * 10
    INT2 = INT2 + IACHAR(CHARA(4:4))-65
    INT2 = INT2 * 10
    INT2 = INT2 + (IACHAR(CHARA(3:3))-58)/4
    INT2 = INT2 * 10
    INT2 = INT2 + (IACHAR(CHARA(2:2))-49)/3
    INT2 = INT2 * 10
    INT2 = INT2 + (IACHAR(CHARA(1:1))-32)/2
    
    INT = INT2

    END SUBROUTINE CHAR2INT
    
    SUBROUTINE INT2CHAR_2(INT, CHA)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: INT
    CHARACTER(LEN = 5), INTENT(OUT) :: CHA
    INTEGER :: INT2, TEM1, TEM2, TEM3, TEM4

    INT2 = INT
    TEM1 = MOD(INT2,10)
    INT2 = INT2/10
    TEM2 = MOD(INT2,10)
    INT2 = INT2/10
    TEM3 = MOD(INT2,10)
    INT2 = INT2/10
    TEM4 = MOD(INT2,10)
    IF(TEM4 == 0)THEN
        IF(TEM3 == 0)THEN
            IF(TEM2 == 0)THEN
                IF(TEM1 == 0)THEN
                    CHA = ACHAR(TEM1+48)
                ELSE
                    CHA = ACHAR(TEM1+48)
                ENDIF
            ELSE
                CHA = ACHAR(TEM2+48)//ACHAR(TEM1+48)
            ENDIF
        ELSE
            CHA = ACHAR(TEM3+48)//ACHAR(TEM2+48)//ACHAR(TEM1+48)
        ENDIF
    ELSE
        CHA = ACHAR(TEM4+48)//ACHAR(TEM3+48)//ACHAR(TEM2+48)//ACHAR(TEM1+48)
    ENDIF

    END SUBROUTINE INT2CHAR_2

    SUBROUTINE INT2HEXCHAR(INT, HEXCHA)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: INT
    CHARACTER(LEN = 2), INTENT(OUT) :: HEXCHA
    INTEGER :: INT2, TEM1, TEM2
    CHARACTER :: CHA1, CHA2

    IF(INT > 256) HEXCHA = 'FF'
    INT2 = INT
    TEM1 = MOD(INT2,16)
    INT2 = INT2/16
    TEM2 = MOD(INT2,16)
    IF(TEM1 == 10)THEN
        CHA1 = 'A'
    ELSEIF(TEM1 == 11)THEN
        CHA1 = 'B'
    ELSEIF(TEM1 == 12)THEN
        CHA1 = 'C'
    ELSEIF(TEM1 == 13)THEN
        CHA1 = 'D'
    ELSEIF(TEM1 == 14)THEN
        CHA1 = 'E'
    ELSEIF(TEM1 == 15)THEN
        CHA1 = 'F'
    ELSE
        CHA1 = ACHAR(TEM1+48)
    ENDIF
    
    IF(TEM2 == 10)THEN
        CHA2 = 'A'
    ELSEIF(TEM2 == 11)THEN
        CHA2 = 'B'
    ELSEIF(TEM2 == 12)THEN
        CHA2 = 'C'
    ELSEIF(TEM2 == 13)THEN
        CHA2 = 'D'
    ELSEIF(TEM2 == 14)THEN
        CHA2 = 'E'
    ELSEIF(TEM2 == 15)THEN
        CHA2 = 'F'
    ELSE
        CHA2 = ACHAR(TEM2+48)
    ENDIF

    HEXCHA = CHA2//CHA1

    END SUBROUTINE INT2HEXCHAR
    
    SUBROUTINE STR_TRIM(STR, LEN_STR_IN, STR_OUT, LEN_STR_OUT)
    IMPLICIT NONE
    CHARACTER(LEN = LEN_STR_IN), INTENT(IN) :: STR
    INTEGER, INTENT(IN) :: LEN_STR_IN
    CHARACTER(LEN = LEN_STR_IN), INTENT(OUT) :: STR_OUT
    INTEGER, INTENT(OUT) :: LEN_STR_OUT
    INTEGER :: IND, IND2, I
    
    IND = 0
    DO I = 1, LEN(STR)
        IF(ICHAR(STR(I:I)) == 32)THEN
            IND = IND + 1
        ELSE
            EXIT
        ENDIF
    ENDDO
    
    IND2 = 0
    DO I = LEN(STR), IND+1, -1
        IF(ICHAR(STR(I:I)) == 32 )THEN
            IND2 = IND2 + 1
        ELSEIF(ICHAR(STR(I:I)) == 0)THEN
            IND2 = IND2 + 1
        ELSE
            EXIT
        ENDIF
    ENDDO
    LEN_STR_OUT = LEN(STR)-IND2 - IND
    DO I = IND+1, LEN(STR)-IND2
        STR_OUT(I-IND:I-IND) = STR(I:I)
    ENDDO

    
    END SUBROUTINE STR_TRIM
    
    
    FUNCTION TIME_NUM_JUDGE(PATH, LEN_PATH, I_MSG_L, I_FLAG)
    USE SHARE_VAR
    USE VAR_INV1D
    USE VAR_ECC_BHC
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: LEN_PATH
    CHARACTER(LEN = LEN_PATH), INTENT(IN) :: PATH
    INTEGER, INTENT(IN) :: I_MSG_L, I_FLAG
    INTEGER :: TIME_NUM_JUDGE
    CHARACTER(LEN = 8) :: DATE
    CHARACTER(LEN = 10) :: TIME
    CHARACTER(LEN = 5) :: ZONE
    INTEGER, DIMENSION(8) :: VALUE0
    INTEGER :: USED_TIME, USED_DAY, USED_MINUTE, USED_DAY_UP, USED_MINUTE_UP
    INTEGER :: DAY_ALL, MINUTE_ALL, DAY_REMAINDER, HOUR_REMAINDER, NUM_REMAINDER
    
    INTEGER, EXTERNAL :: NRAB1
    REAL(KIND = DBL), EXTERNAL :: NRND1
    REAL(KIND = DBL) :: SEED, RAND, TEMP
    INTEGER :: RAN_ST, RAN_EN, RAN_TEMP
    INTEGER :: I, J, I_COUNT
    CHARACTER(LEN = 5) :: CHAR_DAY_REMAINDER, CHAR_HOUR_REMAINDER, CHAR_NUM_REMAINDER, CHAR_TEMP
    CHARACTER(LEN = 5), DIMENSION(8) :: CHAR_VALUE0
    INTEGER :: RET_GET_VAR
    
    TIME_NUM_JUDGE = 0
    CALL DATE_AND_TIME(DATE,TIME,ZONE,VALUE0)
!    PRINT*,VALUE0
    !验证本次使用时间是否晚于上次使用时间
!    USED_TIME = ((VALUE0(1)-TIME_USE(1))*365 + (VALUE0(2)-TIME_USE(2))*30 + (VALUE0(3)-TIME_USE(3)))*24*60 &
!        &   + (VALUE0(5)-TIME_USE(4))*60 + (VALUE0(6)-TIME_USE(5))
!    IF(USED_TIME < 0)THEN
!        TIME_NUM_JUDGE = 1
!        RETURN
!    ENDIF
    
    !计算上次使用时间与注册时间之间的时间
    USED_DAY_UP = ((TIME_USE(1)-TIME_REGISTER(1))*365 + (TIME_USE(2)-TIME_REGISTER(2))*30 + (TIME_USE(3)-TIME_REGISTER(3)))
    USED_MINUTE_UP = (TIME_USE(4)-TIME_REGISTER(4))*60 + (TIME_USE(5)-TIME_REGISTER(5))
    !验证上次使用时间是否晚于注册时间
    IF(USED_DAY_UP < 0)THEN
        TIME_NUM_JUDGE = 1
        RETURN
    ENDIF
    IF(USED_DAY_UP == 0 .AND. USED_MINUTE_UP < 0)THEN
        TIME_NUM_JUDGE = 1
        RETURN
    ENDIF
    IF(USED_MINUTE_UP < 0)THEN
        USED_DAY_UP = USED_DAY_UP - 1
        USED_MINUTE_UP = USED_MINUTE_UP +1440
    ENDIF
    
    DAY_ALL = USED_DAY_UP + DAY_REGISTER
    MINUTE_ALL = USED_MINUTE_UP + HOUR_REGISTER
    IF(MINUTE_ALL > 1440)THEN
        MINUTE_ALL = MINUTE_ALL - 1440
        DAY_ALL = DAY_ALL + 1
    ENDIF
    
    !计算本次使用时间距离注册时间的天数和分钟数
    USED_DAY = ((VALUE0(1)-TIME_REGISTER(1))*365 + (VALUE0(2)-TIME_REGISTER(2))*30 + (VALUE0(3)-TIME_REGISTER(3)))
    USED_MINUTE = (VALUE0(5)-TIME_REGISTER(4))*60 + (VALUE0(6)-TIME_REGISTER(5))
    !验证本次使用时间是否晚于注册时间
    IF(USED_DAY < 0)THEN
        TIME_NUM_JUDGE = 1
        RETURN
    ENDIF
    IF(USED_DAY == 0 .AND. USED_MINUTE < 0)THEN
        TIME_NUM_JUDGE = 1
        RETURN
    ENDIF
    IF(USED_MINUTE < 0)THEN
        USED_DAY = USED_DAY - 1
        USED_MINUTE = USED_MINUTE +1440
    ENDIF
    
    IF(USED_DAY > DAY_ALL)THEN
        TIME_NUM_JUDGE = 1
        RETURN
    ELSEIF(USED_DAY == DAY_ALL)THEN
        IF(USED_MINUTE > MINUTE_ALL)THEN
            TIME_NUM_JUDGE = 1
            RETURN
        ENDIF
    ELSE
        
    ENDIF
    
    DAY_REMAINDER = DAY_ALL - USED_DAY
    HOUR_REMAINDER = MINUTE_ALL - USED_MINUTE
    IF(HOUR_REMAINDER < 0)THEN
        DAY_REMAINDER = DAY_REMAINDER - 1
        HOUR_REMAINDER = HOUR_REMAINDER + 1440
    ENDIF
    
    IF(I_MSG_L*I_FLAG == 0)THEN
        NUM_REMAINDER = NUM_REGISTER - 1
    ELSE
        NUM_REMAINDER = -1
    ENDIF
!    PRINT*,DAY_ALL, MINUTE_ALL, 'DAY MINUTE', DAY_REMAINDER, HOUR_REMAINDER, NUM_REMAINDER
    
    SEED = SQRT(VALUE0(6)*0.5D0 + VALUE0(7)*0.2D0 + VALUE0(8))
    
    DO I = 1, 8
        VALUE0(I) = IEOR(VALUE0(I), RAN)
        CALL INT2CHAR(VALUE0(I), CHAR_VALUE0(I))
    ENDDO
    
    DAY_REMAINDER = IEOR(DAY_REMAINDER, RAN+8)
    CALL INT2CHAR(DAY_REMAINDER, CHAR_DAY_REMAINDER)
    
    HOUR_REMAINDER = IEOR(HOUR_REMAINDER, RAN+16)
    CALL INT2CHAR(HOUR_REMAINDER, CHAR_HOUR_REMAINDER)
    
    NUM_REMAINDER = IEOR(NUM_REMAINDER, RAN+24)
    CALL INT2CHAR(NUM_REMAINDER, CHAR_NUM_REMAINDER)
    
    OPEN(23, FILE = PATH(1:LEN_PATH)//'main.opt', ACCESS = 'DIRECT', FORM = 'UNFORMATTED', RECL = 4, STATUS = 'UNKNOWN', ACTION = 'WRITE')
    COUNT_VAR = COUNT_VAR + 78
    RAN_ST = 10
    RAN_EN = 100
    DO I = 1, NUM_CHAR
        RAND = NRND1(SEED)
        RAN_TEMP = NRAB1(SEED,RAN_ST,RAN_EN)  ! 产生一个随机数
        TEMP = IEOR(IACHAR(CHAR_DAY_REMAINDER(I:I)),RAN_TEMP) + RAND
        WRITE(23, REC=COUNT_VAR+2*I-1)TEMP
        WRITE(23,REC=COUNT_VAR+2*I)RAN_TEMP+RAND
    ENDDO
    COUNT_VAR = COUNT_VAR + 14
    DO I = 1, NUM_CHAR
        RAND = NRND1(SEED)
        RAN_TEMP = NRAB1(SEED,RAN_ST,RAN_EN)  ! 产生一个随机数
        TEMP = IEOR(IACHAR(CHAR_HOUR_REMAINDER(I:I)),RAN_TEMP) + RAND
        WRITE(23, REC=COUNT_VAR+2*I-1)TEMP
        WRITE(23,REC=COUNT_VAR+2*I)RAN_TEMP+RAND
    ENDDO
    COUNT_VAR = COUNT_VAR + 14
    DO I = 1, NUM_CHAR
        RAND = NRND1(SEED)
        RAN_TEMP = NRAB1(SEED,RAN_ST,RAN_EN)  ! 产生一个随机数
        TEMP = IEOR(IACHAR(CHAR_NUM_REMAINDER(I:I)),RAN_TEMP) + RAND
        WRITE(23, REC=COUNT_VAR+2*I-1)TEMP
        WRITE(23,REC=COUNT_VAR+2*I)RAN_TEMP+RAND
    ENDDO
    
    IF(I_FLAG == 1 .AND. I_MSG_L*I_FLAG == 0)THEN
        RET_GET_VAR = GET_VAR2()
    ELSEIF(I_FLAG == 2 .AND. I_MSG_L*I_FLAG == 0)THEN
        RET_GET_VAR = GET_VAR1()
    ELSE
        RET_GET_VAR = 3
    ENDIF

    COUNT_VAR = COUNT_VAR + 14
    I_COUNT = 0
    DO J = 1, 8
        IF(J == 4) CYCLE
        I_COUNT = I_COUNT + 1
        CHAR_TEMP = CHAR_VALUE0(J)
        DO I = 1, NUM_CHAR
            RAND = NRND1(SEED)
            RAN_TEMP = NRAB1(SEED,RAN_ST,RAN_EN)  ! 产生一个随机数
            TEMP = IEOR(IACHAR(CHAR_TEMP(I:I)),RAN_TEMP) + RAND
            WRITE(23, REC=COUNT_VAR+2*I-1+(I_COUNT-1)*NUM_CHAR*2)TEMP
            WRITE(23,REC=COUNT_VAR+2*I+(I_COUNT-1)*NUM_CHAR*2)RAN_TEMP+RAND
        ENDDO
    ENDDO
    CLOSE(23)
    
    IF(RET_GET_VAR .NE. 0)THEN
        TIME_NUM_JUDGE = 2
        RETURN
    ENDIF
    IF(I_MSG_L*I_FLAG .NE. 0) TIME_NUM_JUDGE = 2
    
    END FUNCTION TIME_NUM_JUDGE
    
    REAL*8 FUNCTION NRND1(R)
    DOUBLE PRECISION S,U,V,R
    S=65536.0
    U=2053.0
    V=13849.0
    M=R/S
    R=R-M*S
    R=U*R+V
    M=R/S
    R=R-M*S
    NRND1=R/S
    RETURN
    END
    
    FUNCTION NRAB1(R,A,B)
    INTEGER A,B
    DOUBLE PRECISION R
    
    S=B-A+1.0
    K=LOG(S-0.5)/LOG(2.0)+1
    L=1
    DO 10 I=1,K
10  L=2*L
    K=1
    S=4.0*L
20  IF(K.LE.1)THEN
        R=R+R+R+R+R
        M=R/S
        R=R-M*S
        J=A+R/4.0
        IF(J.LE.B)THEN
            NRAB1=J
            K=K+1
        ENDIF
        GOTO 20
    ENDIF        
    
    RETURN
    END
    