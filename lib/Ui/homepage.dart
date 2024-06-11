import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app2/Bloc/bloc/movie_bloc.dart';
import 'package:movie_app2/Repository/ModelClass/movie_model.dart';
import 'package:movie_app2/Ui/Detailsscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Moviemodel movie;
  @override
  void initState() {
    BlocProvider.of<MovieBloc>(context).add(FetchmovieEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              leading: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 25.sp,
              ),
              title: Text('Movie App',
                  style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900)),
              actions: [
                Stack(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black,
                      size: 30.sp,
                    ),
                    Positioned(
                      top: 5.h,
                      left: 17.w,
                      child: CircleAvatar(
                          radius: 4.r, backgroundColor: Colors.red),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Now Showing',
                    style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900)),
                Container(
                  height: 20.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('See more',
                        style: GoogleFonts.mulish(
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 290.h,
              child: Container(
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is Movieblocloading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MovieblocError) {
                      return RefreshIndicator(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .9,
                            // color: Colors.red,
                            child: const Center(
                                child: Text('Oops something went wrong')),
                          ),
                        ),
                        onRefresh: () async {
                          return BlocProvider.of<MovieBloc>(context)
                              .add(FetchmovieEvent());
                        },
                      );
                    }
                    if (state is Movieblocloaded) {
                      movie = BlocProvider.of<MovieBloc>(context).moviemodel;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.movies!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              width: 160.w,
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 2,
                                    shadowColor: Colors.black,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Detailsscreen(
                                                      model: movie,
                                                      index: index,
                                                    )));
                                      },
                                      child: Container(
                                        height: 210.h,
                                        width: 170.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              movie.movies![index].posterPath
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 110.w,
                                          height: 20.h,
                                          child: Text(
                                              movie.movies![index].title
                                                  .toString(),
                                              style: GoogleFonts.mulish(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular',
                    style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900)),
                Container(
                  height: 20.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('See more',
                        style: GoogleFonts.mulish(
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is Movieblocloading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MovieblocError) {
                  return RefreshIndicator(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .9,
                        // color: Colors.red,
                        child: const Center(
                            child: Text('Oops something went wrong')),
                      ),
                    ),
                    onRefresh: () async {
                      return BlocProvider.of<MovieBloc>(context)
                          .add(FetchmovieEvent());
                    },
                  );
                }
                if (state is Movieblocloaded) {
                  movie = BlocProvider.of<MovieBloc>(context).moviemodel;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: movie.movies!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Detailsscreen(
                                            model: movie,
                                            index: index,
                                          )));
                            },
                            child: Container(
                              height: 140.h,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Card(
                                      elevation: 2,
                                      shadowColor: Colors.black,
                                      child: Container(
                                          height: 210.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                movie.movies![index].posterPath
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        height: 20.h,
                                        child: Text(
                                            movie.movies![index].title
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/img11.png',
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text('8.4/10 IMDb',
                                              style: GoogleFonts.mulish(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 200.w,
                                        child: ListView.builder(
                                          itemCount: movie
                                              .movies![index].genres!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index1) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Container(
                                                height: 20.h,
                                                width: 60.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Color.fromARGB(
                                                        68, 39, 89, 176)),
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 10.h,
                                                    width: 50.w,
                                                    child: Text(
                                                        movie.movies![index]
                                                            .genres![index1]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mulish(
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontSize: 8.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.black,
                                            size: 15.sp,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text('1h 47m',
                                              style: GoogleFonts.mulish(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return SizedBox();
                }
              },
            ))
          ],
        ),
      )),
    );
  }
}
