package vggames.shared.task

import scala.collection.JavaConverters.seqAsJavaListConverter
import scala.collection.mutable.ListBuffer

class Tasks(taskGroups : TaskGroup*) {

  val tasks : List[IndexedTask] = unmodifiableIndexedTasks

  def at(index : Int) = tasks(index)

  def size = tasks.size

  def all : java.util.List[IndexedTask] = tasks.asJava

  private def unmodifiableIndexedTasks = {
    taskGroups.foldLeft((0, List[IndexedTask]())) { (acc, group) =>
      group.foldLeft(acc) { (acc, task) =>
        (acc._1 + 1, acc._2 ++ List(new IndexedTask(new GroupedTask(group, task), acc._1)))
      }
    }._2
  }
}