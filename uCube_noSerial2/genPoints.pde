public void Refresh (int theValue) {
  genPoints();
  if (poly != null) {
    poly = null;
  }
}

public void genPoints() {

  //setup1
  String c000 = "0,0,0;";
  String c010 = "0,1,0;";
  String c020 = "0,2,0;";
  String c030 = "0,3,0;";

  //setup2
  String c001 = "0,0,1;";
  String c011 = "0,1,1;";
  String c021 = "0,2,1;";
  String c031 = "0,3,1;";

  //setup3
  String c002 = "0,0,2;";
  String c012 = "0,1,2;";
  String c022 = "0,2,2;";
  String c032 = "0,3,2;";

  //setup4
  String c003 = "0,0,3;";
  String c013 = "0,1,3;";
  String c023 = "0,2,3;";
  String c033 = "0,3,3;";

  //setup5
  String c100 = "1,0,0;";
  String c110 = "1,1,0;";
  String c120 = "1,2,0;";
  String c130 = "1,3,0;";

  //setup6
  String c101 = "1,0,1;";
  String c111 = "1,1,1;";
  String c121 = "1,2,1;";
  String c131 = "1,3,1;";

  //setup7
  String c102 = "1,0,2;";
  String c112 = "1,1,2;";
  String c122 = "1,2,2;";
  String c132 = "1,3,2;";

  //setup8
  String c103 = "1,0,3;";
  String c113 = "1,1,3;";
  String c123 = "1,2,3;";
  String c133 = "1,3,3;";

  //setup9
  String c200 = "2,0,0;";
  String c210 = "2,1,0;";
  String c220 = "2,2,0;";
  String c230 = "2,3,0;";

  //setup10
  String c201 = "2,0,1;";
  String c211 = "2,1,1;";
  String c221 = "2,2,1;";
  String c231 = "2,3,1;";

  //setup11
  String c202 = "2,0,2;";
  String c212 = "2,1,2;";
  String c222 = "2,2,2;";
  String c232 = "2,3,2;";

  //setup12
  String c203 = "2,0,3;";
  String c213 = "2,1,3;";
  String c223 = "2,2,3;";
  String c233 = "2,3,3;";

  //setup13
  String c300 = "3,0,0;";
  String c310 = "3,1,0;";
  String c320 = "3,2,0;";
  String c330 = "3,3,0;";

  //setup14
  String c301 = "3,0,1;";
  String c311 = "3,1,1;";
  String c321 = "3,2,1;";
  String c331 = "3,3,1;";

  //setup15
  String c302 = "3,0,2;";
  String c312 = "3,1,2;";
  String c322 = "3,2,2;";
  String c332 = "3,3,2;";

  //setup16
  String c303 = "3,0,3;";
  String c313 = "3,1,3;";
  String c323 = "3,2,3;";
  String c333 = "3,3,3;";

  String coord[] = {
    c000, c010, c020, c030, //setup1
    c001, c011, c021, c031, //setup2
    c002, c012, c022, c032, //setup3
    c003, c013, c023, c033, //setup4

    c100, c110, c120, c130, //setup5
    c101, c111, c121, c131, //setup6
    c102, c112, c122, c132, //setup7
    c103, c113, c123, c133, //setup8

    c200, c210, c220, c230, //setup9
    c201, c211, c221, c231, //setup10
    c202, c212, c222, c232, //setup11
    c203, c213, c223, c233, //setup12

    c300, c310, c320, c330, //setup13
    c301, c311, c321, c331, //setup14
    c302, c312, c322, c332, //setup15
    c303, c313, c323, c333  //setup16
  };

  int numCoords = int(random(1,32));    
  String[] c = new String[numCoords];  

  for (int i = 0; i < numCoords; i++) {

    c[i] = coord[int(random(64))];
  }  

  inString = join(c, "");
}

