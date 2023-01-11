class DementiaAnswerFinal{
  static int year = 2023;
  static List<bool> season = [false,false,false,true];
  static List<bool> country = [true, false, false];
  static List<String> words = ['연필', '모자', '나무'];

  static int yearCount = 0;
  static int seasoncount = 0;
  static int countrycount = 0;
  static int wordsCount = 0;
  

  static int total = yearCount+seasoncount+countrycount+wordsCount;

  static int age = 0;

  static String edu = '';
 //var visibility = isPublic ? 'public' : 'private';
  static int edu1 = edu == '초등학교 졸업' ? 1 : 
             edu =='중학교 졸업' ? 2 :
             edu =='고등학교 졸업' ? 3 :
             edu == '대학(2~4년제)' ? 4 : 5;



  static String wage = '';

static int wage1 = wage == '사무직 및 영업직' ? 1 : 
             wage =='소규모 자영업자' ? 2 :
             wage =='현장(숙련)작업자' ? 3 :
             wage == '미숙련 작업자' ? 4 : 5;




  static String gender = '';
static int gender1 = gender == '남자' ? 1 : 0;
           


                
  
}