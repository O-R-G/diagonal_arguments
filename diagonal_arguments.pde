/*
    diagonal arguments

    based on an idea by philip ording
    and with the assistance of chatgpt
    for peano reading group

    17 january 2024
*/

import java.util.HashSet;

PImage img;
int bits = 20;
int size = 800;
int scale = size / bits;
boolean freeze = false;
String[] binary_sequences = new String[bits];

void setup() {
    size(800, 800);
    img = createImage(bits * scale, bits * scale, RGB);
}

void draw() {
    background(0);
    if (!freeze) {
        // populate array with unique random binary sequences
        binary_sequences = new String[bits];    
        for (int y = 0; y < bits;) { 
            String binary_sequence = random_binary_sequence(bits);
            if (!exists(binary_sequences, binary_sequence)) {
                binary_sequences[y] = binary_sequence;
                y++;
            } 
        }
        render_img(); 
    }
    image(img, 0, 0);
}

/*
    functions
*/

void render_img() {
	scale = size / bits;
    for (int y = 0; y < bits; y++) { 
        for (int x = 0; x < bits; x++) {
            char character = binary_sequences[y].charAt(x);
            int bit = character - '0';  // ASCII
            color thiscolor = binary_color(bit);
            for (int i = 0; i < scale; i++) 
                for (int j = 0; j < scale; j++) 
                    img.set(x * scale + i, y * scale + j, thiscolor);
        }
    }
}

String flip_diagonal() {
    String diagonal = "";
    for (int y = 0; y < bits; y++) {
        char character = binary_sequences[y].charAt(y);
        char bitflip = (character == '0') ? '1' : '0';
        char[] charArray = binary_sequences[y].toCharArray();
        charArray[y] = bitflip;
        binary_sequences[y] = new String(charArray);
        diagonal += bitflip;
        render_img();
    }
    println(diagonal);
    return diagonal;
}

String random_binary_sequence(int length) {
    String sequence = "";
    for (int i = 0; i < length; i++)
        sequence += str(floor(random(2)));
    return sequence;
}

boolean exists(String[] binaryStrings, String newString) {
    HashSet<String> binarySet = new HashSet<String>();
    for (String str : binaryStrings)
        binarySet.add(str);
    return binarySet.contains(newString);
}

color binary_color(int bit) {
    return (bit == 0) ? color(0,0,255) : color(255,0,0);
}

/* 
    interaction
*/

void keyPressed() {
  	if (keyCode == ' ')
    	freeze = !freeze;
  	if (keyCode == UP)
		bits /= 2; 
  	if (keyCode == DOWN)
		bits *= 2; 
    if (key == '/')
        flip_diagonal();
}
