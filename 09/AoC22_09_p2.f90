function distance(hx, hy, tx, ty) result(d)
    integer :: hx, hy, tx, ty
    real :: d
    d = int(sqrt(real((hx-tx)**2 + (hy-ty)**2)))
end function

subroutine move(knots, visited, count)
    integer :: dist, count
    integer, dimension(1000, 1000) :: visited
    integer, dimension(10, 2) :: knots
    integer i
    integer, dimension(2) :: A, B, C
    do i = 2, 10
        A = knots(i-1,:)
        B = knots(i,:)
        dist = int(distance(A(1), A(2), B(1), B(2)))
        if (dist > 1) then
            if (A(1) > B(1)) then
                knots(i, 1) = B(1) + 1
            elseif (A(1) < B(1)) then
                knots(i, 1) = B(1) - 1
            endif
            if (A(2) > B(2)) then
                knots(i, 2) = B(2) + 1
            elseif (A(2) < B(2)) then
                knots(i, 2) = B(2) - 1
            endif
        endif
        C = knots(10,:)
        if (visited(C(1),C(2)) == 0) then
            visited(C(1),C(2)) = 1
            count = count + 1
        endif
    end do
end subroutine

program maths
    implicit none
    integer :: i, j
    integer, dimension(1000, 1000) :: visited
    integer, dimension(10, 2) :: knots
    character(len = 9) :: filename
    character :: dir
    integer :: dist, count

    filename='input.txt'

    knots = 500

    visited = 0
    visited(knots(10, 1), knots(10, 2)) = 1
    count = 1
    ! read from ascii file
    open(unit=1,file=filename,status='old') !read from the existing file
    do i = 1,2000
        read(1,*) dir, dist
        print *, dir, dist
        do j = 1, dist
            if (dir == "U") then
                knots(1, 2) = knots(1, 2) + 1
                call move(knots, visited, count)
            elseif (dir == "D") then
                knots(1, 2) = knots(1, 2) - 1
                call move(knots, visited, count)
            elseif (dir == "R") then
                knots(1, 1) = knots(1, 1) + 1
                call move(knots, visited, count)
            elseif (dir == "L") then
                knots(1, 1) = knots(1, 1) - 1
                call move(knots, visited, count)
            endif
        end do
    end do
    close(1)

    !print *, hx, hy
    print *, count

end program maths