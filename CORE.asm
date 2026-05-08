asect 0xE5
sec0:     ds 1
sec1:     ds 1
sec2:     ds 1
sec3:     ds 1

asect 0xF0
in0:      ds 1
in1:      ds 1
in2:      ds 1
in3:      ds 1
ok:       ds 1
bulls:    ds 1
cows:     ds 1
tries:    ds 1
win:      ds 1

asect 0x00
main:
    ldi r0, bulls
    ldi r1, 0
    st  r0, r1

    ldi r0, cows
    st  r0, r1

    ldi r0, tries
    st  r0, r1

    ldi r0, win
    st  r0, r1

loop:
    ldi r0, win
    ld  r0, r1
    if
        tst r1
    is nz
        br finish
    fi

wait_ok:
    ldi r0, ok
    ld  r0, r1
    ldi r3, 1
    if
        cmp r1, r3
    is eq
        br ready
    fi
    br wait_ok

ready:
    # bulls = 0
    ldi r0, bulls
    ldi r1, 0
    st  r0, r1

    # cows = 0
    ldi r0, cows
    st  r0, r1

    # r2 = bulls counter
    ldi r2, 0

    # in0 == sec0
    ldi r0, in0
    ld  r0, r1
    ldi r0, sec0
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # in1 == sec1
    ldi r0, in1
    ld  r0, r1
    ldi r0, sec1
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # in2 == sec2
    ldi r0, in2
    ld  r0, r1
    ldi r0, sec2
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # in3 == sec3
    ldi r0, in3
    ld  r0, r1
    ldi r0, sec3
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # bulls = r2
    ldi r0, bulls
    st  r0, r2

    # win = 1 если bulls == 4
    ldi r3, 4
    if
        cmp r2, r3
    is eq
        ldi r0, win
        ldi r1, 1
        st  r0, r1
    fi

    # r2 = cows counter
    ldi r2, 0

    # cow для in0: sec1, sec2, sec3
    ldi r0, in0
    ld  r0, r1

    ldi r0, sec1
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec2
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec3
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # cow для in1: sec0, sec2, sec3
    ldi r0, in1
    ld  r0, r1

    ldi r0, sec0
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec2
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec3
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # cow для in2: sec0, sec1, sec3
    ldi r0, in2
    ld  r0, r1

    ldi r0, sec0
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec1
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec3
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # cow для in3: sec0, sec1, sec2
    ldi r0, in3
    ld  r0, r1

    ldi r0, sec0
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec1
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    ldi r0, sec2
    ld  r0, r3
    if
        cmp r1, r3
    is eq
        inc r2
    fi

    # cows = r2
    ldi r0, cows
    st  r0, r2

    # tries = tries + 1
    ldi r0, tries
    ld  r0, r1
    inc r1
    st  r0, r1

    # ok = 0
    ldi r0, ok
    ldi r1, 0
    st  r0, r1

    br loop

finish:
    halt

end