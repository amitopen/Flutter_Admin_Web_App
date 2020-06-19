import 'package:canary_admin/Dimens.dart';
import 'package:canary_admin/components/CardContent.dart';
import 'package:canary_admin/components/cardContentTab/CardContentTab.dart';
import 'package:canary_admin/components/CardContentTitle.dart';
import 'package:canary_admin/components/CardGraph/CardGraph.dart';
import 'package:canary_admin/components/CardInfoDashboard.dart';
import 'package:canary_admin/components/ResponsibleRow.dart';
import 'package:canary_admin/components/cardContentTab/ItemTab.dart';
import 'package:canary_admin/order/documents_size.dart';
import 'package:canary_admin/order/get_order_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  String tr="67";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(),
          _buildChart(context),
          _buildContents(context)
        ],
      ),
    );
  }

  _buildHeader() {
    return ResponsibleRow(
      spaceBetween: Dimens.margin_default,
      children: <Widget>[
        CardInfoDashboard(
          color: Colors.orange,
          icon: Icons.content_copy,
          title: "Order Completed",
          information: "100",
          bottomInformation: "Last 30 days",
          iconBottomInformation: Icons.border_all,
        ),
        CardInfoDashboard(
          color: Colors.green,
          icon: Icons.home,
          title: "Revenue",
          information: "\$34,245",
          bottomInformation: "Last 30 days",
          iconBottomInformation: Icons.today,
        ),
        CardInfoDashboard(
          color: Colors.red,
          icon: Icons.home,
          title: "Pending Order",
          information: tr,
          bottomInformation: "Last 30 days",
          iconBottomInformation: Icons.warning,
        ),
        CardInfoDashboard(
          color: Colors.lightBlue,
          icon: Icons.people,
          title: "Followers",
          information: "+245",
          bottomInformation: "Just Updated",
          iconBottomInformation: Icons.update,
        ),
      ],
    );
  }

  _buildChart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: ResponsibleRow(
        spaceBetween: Dimens.margin_default,
        children: <Widget>[
          CardGraph(
            title: "Daily Sales",
            subTitle: "55% increase in today sales.",
            bottomText: "updated 4 minutes ago",
            color: Colors.green,

          ),
          CardGraph(
            title: "Email Subscriptions",
            subTitle: "Last Campaign Performance",
            bottomText: "campaign sent 2 days ago",
            color: Colors.orange,
          ),
          CardGraph(
            title: "Completed Tasks",
            subTitle: "Last Campaign Performance",
            bottomText: "campaign sent 2 days ago",
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  _buildContents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:Dimens.margin_default),
      child: ResponsibleRow(
        spaceBetween: Dimens.margin_default,
        children: <Widget>[
          CardContentTitle(
            title: "Employees Stats",
            subtitle: "New emplldksljdlksj ldskfjdslkfjds ",
            content: Container( height: 150.0,),
            color: Colors.orange,
          ),
          CardContentTab(
              [
            ItemTab("BUGS", Icons.bug_report, Container( height: 150.0, child: Text("BUGS A LOT"))),
            ItemTab("WEBSITE", Icons.chevron_left, Container( height: 150.0, child: Text("WEBSITES"))),
            ItemTab("SERVER", Icons.cloud, Container(height: 150.0, child: Text("SERVERS")))
          ],
              title: "Tasks:",
            color: Colors.purple,
          )
        ],
      ),
    );
  }

}
