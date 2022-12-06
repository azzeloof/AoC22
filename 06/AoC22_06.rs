use std::env;
use std::fs;

fn areUnique(bite: &str) -> bool {
    let mut i = 0;
    let mut unique = true;
    let mut cur = " ";
    while i < bite.chars().count() {
        cur = &bite[i..i+1];
        //println!("{}", cur);
        if bite.matches(cur).count() > 1 {
            unique = false
        }
        i = i + 1;
    }
    unique
}

fn scan(contents: &str, n: usize) {
    let mut i = 0;
    while i < contents.chars().count()-n+1 {
        if areUnique(&contents[i..i+n]) {
            println!("First unique string: {}", {&contents[i..i+n]});
            println!("Ends at: {}", {i+n});
            break;
        }
        i = i + 1;
    }
}

fn main() {
    println!("In file {}", "input.txt");

    let contents = fs::read_to_string("input.txt")
        .expect("Should have been able to read the file");

    println!("Part 1:");
    scan(&contents, 4);
    
    println!("Part 2:");
    scan(&contents, 14);
}
