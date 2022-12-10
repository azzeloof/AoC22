function distance(hx, hy, tx, ty) result(d)
    integer :: hx, hy, tx, ty
    real :: d
    d = int(sqrt(real((hx-tx)**2 + (hy-ty)**2)))
end function

subroutine moveT(hx, hy, tx, ty, visited, count)
    integer :: hx, hy, tx, ty, dist, count
    integer, dimension(1000, 1000) :: visited
    dist = int(distance(hx, hy, tx, ty))
    if (dist > 1) then
        if (hx > tx) then
            tx = tx + 1
        elseif (hx < tx) then
            tx = tx - 1
        endif
        if (hy > ty) then
            ty = ty + 1
        elseif (hy < ty) then
            ty = ty - 1
        endif
        if (visited(tx,ty) == 0) then
            visited(tx,ty) = 1
            count = count + 1
        endif
    endif
end subroutine

program maths
    implicit none
    integer :: i, j
    integer :: hx, hy, tx, ty
    integer, dimension(1000, 1000) :: visited
    character(len = 9) :: filename
    character :: dir
    integer :: dist, count

    filename='input.txt'

    hx = 500
    hy = 500
    tx = 500
    ty = 500

    visited = 0
    visited(tx, ty) = 1
    count = 1
    ! read from ascii file
    open(unit=1,file=filename,status='old') !read from the existing file
    do i = 1,2000
        read(1,*) dir, dist
        print *, dir, dist
        do j = 1, dist
            if (dir == "U") then
                hy = hy + 1
                call moveT(hx, hy, tx, ty, visited, count)
            elseif (dir == "D") then
                hy = hy - 1
                call moveT(hx, hy, tx, ty, visited, count)
            elseif (dir == "R") then
                hx = hx + 1
                call moveT(hx, hy, tx, ty, visited, count)
            elseif (dir == "L") then
                hx = hx - 1
                call moveT(hx, hy, tx, ty, visited, count)
            endif
        end do
    end do
    close(1)

    !print *, hx, hy
    print *, count

end program maths