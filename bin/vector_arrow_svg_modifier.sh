#!/bin/bash
#
# vector_arrow_svg_modifier.sh
#
#    2023.02.23:  Akira Kageyama
#
# SVGで描いた矢印群の見え方を変更し、別のSVGファイル（複数）を生成するスクリプト
#  
#  変更するのは
#    - 個々の矢印の大きさ（矢印テンプレートのスケール）
#    - 矢印を描画する格子点のストライド（全ての格子点で描くか、2^n個毎に描くか）
#  の2つである。
# 
#  入力SVGファイルをウェブブラウザでECMAScript等を介して対話的に変更することも
#  できるが、時間発展データの動画化をする場合等にスクリプト処理が必要となるので、
#  このスクリプトは有用であろう。
#  
#  入力のSVGファイルは以下の形式を想定している。
# 
#  ----------------------------------------------------------------------
#  <svg xmlns="http://www.w3.org/2000/svg" 
#       xmlns:xlink="http://www.w3.org/1999/xlink" 
#       width="1200.00" height="720.00" 
#       viewBox=".00 .00 1200.00 720.00" >
# 
#  <defs>
#    <g id="arrow-template01">
#      <g id="arrow-template01-scale" transform="scale(1.0)">
#        <line x1="-20.00" y1=".00" x2="10.00" y2=".00" stroke-width="4.00" />
#        <polygon points="20.00,.00 10.00,-5.00 10.00,5.00" />
#      </g>
#    </g>
#  </defs>
#  
#  <g stroke="【中略】>
#    <g id="arrow-skip3" visibility="visible" >
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.37)" />
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.46)" />
#            ...
#    </g>
#    <g id="arrow-skip2" visibility="visible" >
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.47)" />
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.32)" />
#            ...
#    </g>
#    <g id="arrow-skip1" visibility="visible" >
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.43)" />
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.49)" />
#            ...
#    </g>
#    <g id="arrow-skip0" visibility="visible" >
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.23)" />
#      <use xlink:href="#arrow-template01" transform="【中略】scale(.29)" />
#            ...
#    </g>
#  </g>
#  【略】
#  </svg>
#  ----------------------------------------------------------------------
# 
# 
#  上のSVGデータは 以下のeFortranコードで生成した。
# 
#   *************************************************************************
#   subroutine slice__vector_vis_arrows 
#     【略】
#     allocate(pass_to_sketch_flag(this.mesh_vert.nu,this.mesh_vert.nv))
#     pass_to_sketch_flag(:,:) = .false.
# 
#     do skip = 3, 0, -1
#       stride = 2**skip
#       write(tag_for_group,"(a,i1)") "arrow-skip", skip
#         ! "arrow-skip4, arrow-skip3, ...
#       call sketch.group_push( id=trim(tag_for_group),  &
#                               visibility="visible" )
#         do j = 1, this.mesh_vert.nv, stride
#           do i = 1, this.mesh_vert.nu, stride
#             if ( .not. pass_to_sketch_flag(i,j) ) then
#               u = this.mesh_vert.pos_u(i)
#               v = this.mesh_vert.pos_v(j)
#               call sketch.arrow( u, v, &
#                                  this.vect_u(i,j), &
#                                  this.vect_v(i,j) )
#               pass_to_sketch_flag(i,j) = .true.
#             end if
#           end do
#         end do
#       call sketch.group_pop()
#     end do
# 
#     deallocate(pass_to_sketch_flag)
#   end subroutine slice__vector_vis_arrows 
#   *************************************************************************
#   
#   各格子に割り当てた整数 "skip" を使って表示する矢印を調整する。
#
#     o--o--o--o--o--o--o--o--o <== Original (=finest) grid
#     |  |  |  |  |  |  |  |  |
#     o-----o-----o-----o-----o <== Coarse grid (stride=2)
#     |  |  |  |  |  |  |  |  |
#     o-----------o-----------o <== Coarser grid (stride=4)
#     |  |  |  |  |  |  |  |  |
#     o-----------------------o <== Coarser2 grid (stride=8)
#     |  |  |  |  |  |  |  |  |
#     3  0  1  0  2  0  1  0  3 <====== "skip"
#   
#   デフォルトでは全てのskip値をもつ格子上の矢印がvisibleになっているので、
#   finest を表示をするには何も操作する必要なし。
#   coarse 格子を表示するには、skip=0の格子上の矢印をhiddenにする。
#   coarser 格子を表示するには、skip=0と1の格子上の矢印をhiddenにする。
#   coarser2 格子を表示するには、skip=0と1と2の格子上の矢印をhiddenにする。
#

function scale_transform() {
  # 入力SVGファイルでは矢印のテンプレートがarrow-template01というidをつけて
  #    <g id="arrow-template01">
  # としてグループ化されている。これをuseして（回転とスケール変換をして）
  # 各格子点に矢印を描く。このときのスケール変換は各格子点上のベクトルの
  # 値に比例する。こうして描かれた矢印群全体の大きさを一定の割合で変更するために
  # 矢印テンプレートの大きさそのものをスケール変換する。そのために矢印テンプレート
  # 自体を次のグループに入れて別のid（arrow-template01-scale）をつけておく。
  #    <g id="arrow-template01-scale" transform="scale(1.0)">
  # この行のscaleの値をsedで変更する。
  scale=$2
  id_line="id=\"arrow-template01-scale\""
  string_before="transform=\"scale(1.0)\""
  string_after="transform=\"scale(${scale})\""
  cat $1 | sed "/$id_line/s/$string_before/$string_after/"
}

function make_it_coarse() {
  cat $1 | sed '/id="arrow-skip0"/s/visible/hidden/'
}

function make_it_coarser() {
  cat $1 | sed '/id="arrow-skip0"/s/visible/hidden/' \
         | sed '/id="arrow-skip1"/s/visible/hidden/'
}

function make_it_coarser2() {
  cat $1 | sed '/id="arrow-skip0"/s/visible/hidden/' \
         | sed '/id="arrow-skip1"/s/visible/hidden/' \
         | sed '/id="arrow-skip2"/s/visible/hidden/'
}


command=`basename $0`

if [ $# -ne 2 ]; then
  echo "Usage: $command input_vector.svg scale" 1>&2
  echo " e.g., $command input_vector.svg 0.2" 1>&2
  exit 1
fi

input_svg=$1
input_svg_namebase=`basename $input_svg`

scale=$2

scaled_svg=_${input_svg_namebase}__scale_${scale}

  scaled_svg_finest=${scaled_svg}_finest.svg
  scaled_svg_coarse=${scaled_svg}_coarse.svg
 scaled_svg_coarser=${scaled_svg}_coarser.svg
scaled_svg_coarser2=${scaled_svg}_coarser2.svg

scale_transform $input_svg $scale > $scaled_svg_finest

make_it_coarse   $scaled_svg_finest > $scaled_svg_coarse
make_it_coarser  $scaled_svg_finest > $scaled_svg_coarser
make_it_coarser2 $scaled_svg_finest > $scaled_svg_coarser2

exit 1
